//
//  PersistanceManager.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 3.12.2022.
//

import Foundation

enum PersistanceActionType {
    case add, remove
}

protocol PersistanceManagerProtocol {
    func updateDataWith(newFavorite: Follower, actionType:PersistanceActionType ,completion: @escaping(GFError?) -> Void)
    func retrieveData(completion: @escaping(Result<[Follower], GFError>) -> Void)
    func save(favorites: [Follower]) -> GFError?
}

final class PersistanceManager: PersistanceManagerProtocol {
    let defaults = UserDefaults.standard
    enum DefaultsKey {
        static let favorites = "favorites"
    }
    
    func updateDataWith(newFavorite: Follower, actionType:PersistanceActionType ,completion: @escaping(GFError?) -> Void) {
        retrieveData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(var favorites):
                switch actionType {
                case .add:
                    guard !favorites.contains(newFavorite) else {
                        completion(.alreadyInFavorites)
                        return
                    }
                    
                    favorites.append(newFavorite)
                case .remove:
                    favorites.removeAll { $0.login == newFavorite.login }
                }
                
                completion(self.save(favorites: favorites))
            case .failure(let error):
                completion(error)
                return
            }
        }
    }
    
    func retrieveData(completion: @escaping(Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: DefaultsKey.favorites) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let decodedFavorites = try JSONDecoder().decode([Follower].self, from: favoritesData)
            completion(.success(decodedFavorites))
        }
        catch {
            completion(.failure(.unableToComplete))
        }
    }
    
    func save(favorites: [Follower]) -> GFError?{
        do {
            let encodedFavorites = try JSONEncoder().encode(favorites)
            defaults.set(encodedFavorites, forKey: DefaultsKey.favorites)
            return nil
        }
        catch {
            return .unableToFavorite
        }
    }
}
