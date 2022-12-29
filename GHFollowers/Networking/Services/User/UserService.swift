//
//  UserService.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 29.12.2022.
//

import Foundation

protocol UserServiceProtocol {
    func fetchUserInfo(username: String,completion: @escaping(Result<User, ServiceError>) -> Void)
}

final class UserService: UserServiceProtocol {
    private var service: ServiceProtocol!
    
    init(service: ServiceProtocol!) {
        self.service = service
    }
    
    func fetchUserInfo(username: String,completion: @escaping(Result<User, ServiceError>) -> Void) {
        service.fetch(endPoint: UserEndPoint.fetchUserInfos(username: username)) { (result: Result<User, ServiceError>) in
            completion(result)
        }
    }
}
