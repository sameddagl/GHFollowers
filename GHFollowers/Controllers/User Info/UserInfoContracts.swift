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
    case getGithubPage(url: String)
    case getFollowers
    case errorOccured(title: String, message: String)
    case userItSelf(Bool)
}

protocol UserInfoVMDelegate: AnyObject {
    func handleOutput(_ output: UserInfoOutputs)
}
