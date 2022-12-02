//
//  NetworkLayer.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 25.11.2022.
//

import UIKit

protocol NetworkLayerProtocol {
    func fetchFollowers(with username: String, page: Int, completion: @escaping(Result<[Follower], GFError>) -> Void)
}

final class NetworkLayer: NetworkLayerProtocol {
    static let shared = NetworkLayer()
    
    private let baseURL = "https://api.github.com/users/"
    
    private let cache = NSCache<NSString, UIImage>()

    
    func fetchFollowers(with username: String, page: Int, completion: @escaping(Result<[Follower], GFError>) -> Void) {
        let endPoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.noUser))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedData = try decoder.decode([Follower].self, from: data)
                completion(.success(decodedData))
            }
            catch {
                completion(.failure(.invalidData))
            }
        }.resume()
    }
    
    func fetchUserInfo(with username: String, completion: @escaping(Result<User, GFError>) -> Void) {
        let endPoint = baseURL + "\(username)"
        
        guard let url = URL(string: endPoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.noUser))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let decodedData = try decoder.decode(User.self, from: data)
                completion(.success(decodedData))
            }
            catch {
                completion(.failure(.invalidData))
            }
        }.resume()
    }
    
    func downloadImage(withURL url: String, completion: @escaping(UIImage?) -> Void) {
        let key = NSString(string: url)
        
        if let image = cache.object(forKey: key) {
            completion(image)
            return
        }
        
        guard let url = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let _ = error {
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let image = UIImage(data: data) else { return }
            
            self?.cache.setObject(image, forKey: key)
            
            completion(image)
            
        }.resume()
    }
}
