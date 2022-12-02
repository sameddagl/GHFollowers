//
//  UserInfoPresentation.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 3.12.2022.
//

import Foundation

struct UserInfoPresentation {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: Date
    
    init(login: String, avatarUrl: String, name: String? = nil, location: String? = nil, bio: String? = nil, publicRepos: Int, publicGists: Int, htmlUrl: String, following: Int, followers: Int, createdAt: Date) {
        self.login = login
        self.avatarUrl = avatarUrl
        self.name = name
        self.location = location
        self.bio = bio
        self.publicRepos = publicRepos
        self.publicGists = publicGists
        self.htmlUrl = htmlUrl
        self.following = following
        self.followers = followers
        self.createdAt = createdAt
    }
    
    init(user: User) {
        self.login = user.login
        self.avatarUrl = user.avatarUrl
        self.name = user.name
        self.location = user.location
        self.bio = user.bio
        self.publicRepos = user.publicRepos
        self.publicGists = user.publicGists
        self.htmlUrl = user.htmlUrl
        self.following = user.following
        self.followers = user.followers
        self.createdAt = user.createdAt
    }
}
