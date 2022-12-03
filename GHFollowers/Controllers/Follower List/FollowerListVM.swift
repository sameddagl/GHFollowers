//
//  FollowerListVM.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 2.12.2022.
//

import Foundation

final class FollowerListVM: FollowerListVMProtocol {
    weak var delegate: FollowerListDelegate?
    
    private let service: NetworkLayerProtocol
    private let persistanceManager: PersistanceManagerProtocol
    
    private var userName: String
    private var currentPage = 1
    private var hasMoreFollowers = true
    private var isSearching = false
    private var followers = [Follower]()
    private var filteredFollowers = [Follower]()
    
    init(username: String, service: NetworkLayerProtocol, persistanceManager: PersistanceManagerProtocol) {
        self.userName = username
        self.service = service
        self.persistanceManager = persistanceManager
    }
    
    func load() {
        notify(.updateTitle(userName))
        notify(.isLoading(true))
        service.fetchFollowers(with: userName, page: currentPage) { [weak self] result in
            guard let self = self else { return }
            self.notify(.isLoading(false))
            switch result {
            case .success(let followers):
                if followers.count < 100 {
                    self.hasMoreFollowers = false
                }
                self.followers.append(contentsOf: followers)
                let followerPresentation = self.followers.map({FollowerListPresentation(follower: $0)})
                self.notify(.updateFollowers(followers: followerPresentation))
            case .failure(let error):
                self.notify(.throwAlert(title: "An error occured", message: error.rawValue))
            }
        }
    }
    
    func searchForUser(filter: String?) {
        filteredFollowers.removeAll()
        guard let filter = filter, !filter.isEmpty else {
            isSearching = false
            let followerPresentation = followers.map({FollowerListPresentation(follower: $0)})
            notify(.updateSearchResults(followers: followerPresentation))
            return
        }
        isSearching = true
        filteredFollowers = followers.filter{$0.login.lowercased().contains(filter.lowercased())}
        let followerPresentation = filteredFollowers.map({FollowerListPresentation(follower: $0)})
        notify(.updateSearchResults(followers: followerPresentation))
    }
    
    func pagination(height: CGFloat, contentHeight: CGFloat, offset: CGFloat) {
        if height + offset >= contentHeight && hasMoreFollowers {
            currentPage += 1
            load()
        }
    }
    
    func getUserInfo(at index: Int) {
        //TODO
        let selectedItem = isSearching ? filteredFollowers[index] : followers[index]
        delegate?.navigate(to: .userInfo(rootVM:self, selectedUser: selectedItem.login, userItSelf: false))
    }
    
    func getUserInfo() {
        delegate?.navigate(to: .userInfo(rootVM:self, selectedUser: self.userName, userItSelf: true))
    }
    
    private func saveUser(user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        persistanceManager.updateDataWith(newFavorite: favorite, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                if error == .alreadyInFavorites {
                    self.notify(.throwAlert(title: "Unable to favorite", message: "You have already favorited this user."))
                }
                else {
                    self.notify(.throwAlert(title: "Something went wrong", message: error.rawValue))
                }
            }
            else {
                self.notify(.throwAlert(title: "Success!", message: "You have sucessfully favorited this user."))
            }
        }
    }
    
    func saveUserTapped() {
        service.fetchUserInfo(with: userName) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.saveUser(user: user)
            case .failure(let error):
                self.notify(.throwAlert(title: "An error occurde", message: error.rawValue))
            }
        }
    }

    
    func didRequestFollowers(username: String) {
        followers.removeAll()
        self.userName = username
        currentPage = 1
        load()
        notify(.scrollToTop)
    }

    private func notify(_ output: FollowerListOutputs) {
        delegate?.handleOutputs(output)
    }
}

extension FollowerListVM: UserInfoDelegate {
    func didRequestFollowers(with username: String) {
        self.didRequestFollowers(username: username)
    }
}