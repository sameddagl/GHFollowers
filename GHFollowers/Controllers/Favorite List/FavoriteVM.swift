//
//  FavoriteVM.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 3.12.2022.
//

import Foundation

final class FavoriteVM: FavoriteListVMProtocol {
    weak var delegate: FavoriteListVMDelegate?
    
    private let persistanceManager: PersistanceManagerProtocol
    private var favorites = [Follower]()
    
    init(persistanceManager: PersistanceManagerProtocol) {
        self.persistanceManager = persistanceManager
    }
    
    //MARK: - Load with favorites
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
    
    //MARK: - User select a favorite
    func selectItem(at index: Int) {
        let selectedItem = FavoriteListPresentation(user: favorites[index])
        notify(.popUpUserInfoScreen(viewModel: UserInfoVM(username: selectedItem.username, userItself: false, service: app.service)))
    }
    
    //MARK: - User delete a favorite
    func removeFromFavorites(at index: Int) {
        let userToRemove = favorites[index]
        persistanceManager.updateDataWith(newFavorite: userToRemove, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.notify(.errorOccured(title: "Unable to complete", message: error.rawValue))
                return
            }
            self.favorites.remove(at: index)
            self.notify(.removeFromFavoritesAt(index: index))
        }
    }
    
    //MARK: - User select to get followers from user info
    func didRequestFollowers(username: String) {
        notify(.didRequestFollowers(viewModel: FollowerListVM(username: username, service: app.service, persistanceManager: app.persistanceManager)))
    }
    
    private func notify(_ output: FavoriteListOutputs) {
        delegate?.handleOutput(output)
    }
}

