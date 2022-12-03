//
//  FavoriteVM.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 3.12.2022.
//

import Foundation

final class FavoriteVM: FavoriteListVMProtocol {
    var delegate: FavoriteListVMDelegate?
    
    private let persistanceManager: PersistanceManagerProtocol
    private var favorites = [Follower]()
    
    init(persistanceManager: PersistanceManagerProtocol) {
        self.persistanceManager = persistanceManager
    }
    
    func load() {
        persistanceManager.retrieveData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                self.favorites = favorites
                self.notify(.updateData(favorites: favorites.map {FavoriteListPresentation(user: $0)}))
            case .failure(let error):
                self.notify(.errorOccured(title: "An error occred", message: error.rawValue))
            }
        }
    }
    
    func selectItem(at index: Int) {
        #warning("TODO")
    }
    
    private func notify(_ output: FavoriteListOutputs) {
        delegate?.handleOutput(output)
    }
}
