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
}

enum FavoriteListOutputs {
    case updateData(favorites: [FavoriteListPresentation])
    case errorOccured(title: String, message: String)
}

protocol FavoriteListVMDelegate {
    func handleOutput(_ output: FavoriteListOutputs)
}
