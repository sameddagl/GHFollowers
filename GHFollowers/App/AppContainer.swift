//
//  AppContainer.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 3.12.2022.
//

import Foundation

struct AppContainer {
    static let service = Service()
    static let persistanceManager = PersistanceManager()
}

struct ServiceContainer {
    static let followerService = FollowerService(service: AppContainer.service)
    static let userService = UserService(service: AppContainer.service)
}
