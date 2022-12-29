//
//  UserEndPoint.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 29.12.2022.
//

import Foundation

enum UserEndPoint: HTTPEndPoint {
    case fetchUserInfos(username: String)
    
    var path: String {
        switch self {
        case .fetchUserInfos(let username):
            return "/users/\(username)"
        }
    }
    
    var params: [URLQueryItem] {
        switch self {
        case .fetchUserInfos(_):
            return []
        }
    }
}
