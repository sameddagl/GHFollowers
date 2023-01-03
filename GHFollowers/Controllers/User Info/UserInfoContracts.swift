//
//  UserInfoContracts.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 3.12.2022.
//

import Foundation

protocol UserInfoVMProtocol {
    var delegate: UserInfoVMDelegate? { get set }
    func load()
    func getGithubPage(withURL url: String)
    func getFollowers()
}

enum UserInfoOutputs {
    case isLoading(Bool)
    case updateUserInfo(UserInfoPresentation)
    case errorOccured(title: String, message: String)
    case userItSelf(Bool)
}

enum UserInfoRoute {
    case githubPage(url: String)
    case followerList(username: String)
}

protocol UserInfoVMDelegate: AnyObject {
    func handleOutput(_ output: UserInfoOutputs)
    func navigate(to route: UserInfoRoute)
}
