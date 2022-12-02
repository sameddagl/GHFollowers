//
//  UserInfoVM.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 3.12.2022.
//

import Foundation

final class UserInfoVM: UserInfoVMProtocol {
    weak var delegate: UserInfoVMDelegate?
    weak var requestFollowersDelegate: UserInfoDelegate?
    
    private let service: NetworkLayerProtocol
    
    private var username: String!
    
    init(username: String, service: NetworkLayerProtocol) {
        self.username = username
        self.service = service
    }
    
    func load() {
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
    
    func getGithubPage(withURL url: String) {
        notify(.getGithubPage(url: url))
    }
    
    func getFollowers() {
        requestFollowersDelegate?.didRequestFollowers(with: username)
        notify(.getFollowers)
    }
    
    private func notify(_ output: UserInfoOutputs) {
        delegate?.handleOutput(output)
    }
}


