//
//  Service.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 29.12.2022.
//

import UIKit

protocol ServiceProtocol {
    func fetch<T: Codable>(endPoint: HTTPEndPoint, completion: @escaping(Result<T, ServiceError>) -> Void)
    func downloadImage(withURL url: String, completion: @escaping(UIImage?) -> Void)

}
final class Service: ServiceProtocol {
    private let cache = NSCache<NSString, UIImage>()

    func fetch<T>(endPoint: HTTPEndPoint, completion: @escaping (Result<T, ServiceError>) -> Void) where T : Decodable, T : Encodable {
        var components = URLComponents()
        components.scheme = endPoint.scheme
        components.host = endPoint.host
        components.path = endPoint.path
        
        guard let url = components.url else {
            completion(.failure(.invalidUsername))
            return
        }
                
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
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
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            }
            catch {
                print(error)
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
