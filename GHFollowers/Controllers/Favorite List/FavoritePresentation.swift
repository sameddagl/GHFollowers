//
//  FavoritePresentation.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 3.12.2022.
//

import Foundation

struct FavoriteListPresentation {
    let username: String
    let avatarURL: String
    
    init(username: String, avatarURL: String) {
        self.username = username
        self.avatarURL = avatarURL
    }
    
    init(user: Follower) {
        self.username = user.login
        self.avatarURL = user.avatarUrl
    }
}
