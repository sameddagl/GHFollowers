//
//  UserInfoVM.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 3.12.2022.
//

import Foundation

final class UserInfoVM: UserInfoVMProtocol {
    weak var delegate: UserInfoVMDelegate?
    
    private let service: NetworkLayerProtocol
    
    private var username: String!
    private var userItself: Bool
    
    init(username: String, userItself: Bool, service: NetworkLayerProtocol) {
        self.username = username
        self.service = service
        self.userItself = userItself
    }
    
    //MARK: - Load with user info
    func load() {
        notify(.userItSelf(userItself))
        notify(.isLoading(true))
        service.fetchUserInfo(with: username) { [weak self] result in
            guard let self = self else { return }
            self.notify(.isLoading(false))
            switch result {
            case .success(let user):
                self.notify(.updateUserInfo(UserInfoPresentation(user: user)))
            case .failure(let error):
                self.notify(.errorOccured(title: "An error occured", message: error.rawValue))
            }
        }
    }
    
    //MARK: - User select to get github page
    func getGithubPage(withURL url: String) {
        notify(.getGithubPage(url: url))
    }
    
    //MARK: - User select to get followers of user
    func getFollowers() {
        notify(.getFollowers(username: username))
    }
    
    //MARK: - Handle with outputs
    private func notify(_ output: UserInfoOutputs) {
        delegate?.handleOutput(output)
    }
}



