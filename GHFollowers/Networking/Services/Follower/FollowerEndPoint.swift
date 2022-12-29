//
//  FollowerEndPoint.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 29.12.2022.
//

import Foundation

enum FollowerEndPoint: HTTPEndPoint {
    case fetchFollowers(username: String, page: Int)
    
    var path: String {
        switch self {
        case .fetchFollowers(let username, _):
            return "/users/\(username)/followers"
        }
    }
    
    var params: [URLQueryItem] {
        switch self {
        case .fetchFollowers(_, let page):
            return [
                URLQueryItem(name: "per_page", value: "100"),
                URLQueryItem(name: "page", value: String(page))
            ]
        }
    }
}
