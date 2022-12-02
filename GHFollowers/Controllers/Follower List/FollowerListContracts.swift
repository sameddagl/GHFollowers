//
//  FollowerListContracts.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 2.12.2022.
//

import Foundation

protocol FollowerListVMProtocol {
    var delegate: FollowerListDelegate? { get set }
    func load()
    func pagination(height: CGFloat, contentHeight: CGFloat, offset: CGFloat)
    func searchForUser(filter: String?)
    func getUserInfo(at index: Int)
    func getUserInfo()
    func didRequestFollowers(username: String)
}

enum FollowerListOutputs {
    case updateTitle(String)
    case isLoading(Bool)
    case updateFollowers(followers: [FollowerListPresentation])
    case updateSearchResults(followers: [FollowerListPresentation])
    case errorOccured(title: String, message: String)
}

enum FollowerListRoute {
    case userInfo(selectedUser: String)
}

protocol FollowerListDelegate: AnyObject {
    func handleOutputs(_ output: FollowerListOutputs)
    func navigate(to route: FollowerListRoute)
}

