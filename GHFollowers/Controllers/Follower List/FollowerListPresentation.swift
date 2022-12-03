//
//  FollowerListPresentation.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 2.12.2022.
//

import Foundation

struct FollowerListPresentation: Hashable {
    var login: String
    var avatarUrl: String
    
    init(login: String, avatarUrl: String) {
        self.login = login
        self.avatarUrl = avatarUrl
    }
    
    init(follower: Follower) {
        self.login = follower.login
        self.avatarUrl = follower.avatarUrl
    }
}
