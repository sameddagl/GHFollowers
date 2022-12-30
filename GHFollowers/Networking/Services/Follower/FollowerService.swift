//
//  FollowerService.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 29.12.2022.
//

import Foundation

protocol FollowerServiceProtocol {
    func fetchFollowers(username: String, page: Int, completion: @escaping(Result<[Follower], ServiceError>) -> Void)
}

final class FollowerService: FollowerServiceProtocol {
    private var service: ServiceProtocol!
    
    init(service: ServiceProtocol!) {
        self.service = service
    }
    
    func fetchFollowers(username: String, page: Int, completion: @escaping (Result<[Follower], ServiceError>) -> Void) {
        service.fetch(endPoint: FollowerEndPoint.fetchFollowers(username: username, page: page)) { (result: Result<[Follower], ServiceError>) in
            completion(result)
        }
    }
}
