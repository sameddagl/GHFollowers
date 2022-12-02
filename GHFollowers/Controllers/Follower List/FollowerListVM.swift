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
    
    private var userName: String
    private var currentPage = 1
    private var hasMoreFollowers = true
    private var isSearching = false
    private var followers = [Follower]()
    private var filteredFollowers = [Follower]()
    
    
    init(username: String, service: NetworkLayerProtocol) {
        self.userName = username
        self.service = service
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
                self.notify(.errorOccured(title: "An error occured", message: error.rawValue))
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
        delegate?.navigate(to: .userInfo(selectedUser: selectedItem.login))
    }
    
    func getUserInfo() {
        delegate?.navigate(to: .userInfo(selectedUser: self.userName))
    }

    
    func didRequestFollowers(username: String) {
        followers.removeAll()
        self.userName = username
        currentPage = 1
        load()
    }

    


    
    private func notify(_ output: FollowerListOutputs) {
        delegate?.handleOutputs(output)
    }
}
