//
//  FavoriteContracts.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 3.12.2022.
//

import Foundation

protocol FavoriteListVMProtocol {
    var delegate: FavoriteListVMDelegate? { get set }
    func load()
    func selectItem(at index: Int)
    func removeFromFavorites(at index: Int)
    func didRequestFollowers(username: String)
}

enum FavoriteListOutputs {
    case updateData(favorites: [FavoriteListPresentation])
    case removeFromFavoritesAt(index: Int)
    case popUpUserInfoScreen(viewModel: UserInfoVMProtocol)
    case didRequestFollowers(viewModel: FollowerListVMProtocol)
    case errorOccured(title: String, message: String)
}

protocol FavoriteListVMDelegate: AnyObject {
    func handleOutput(_ output: FavoriteListOutputs)
}
