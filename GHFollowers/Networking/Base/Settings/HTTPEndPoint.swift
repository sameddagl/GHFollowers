//
//  HttpEntPoint.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 29.12.2022.
//

import Foundation

protocol HTTPEndPoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var params: [URLQueryItem] { get }
    var method: HTTPMethod { get }
}

extension HTTPEndPoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "api.github.com"
    }
    
    var method: HTTPMethod {
        return .get
    }
}
