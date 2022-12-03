//
//  FavoriteListBuilder.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 3.12.2022.
//

import UIKit

final class FavoriteListBuilder {
    static func make() -> FavoriteListVC{
        let vc = FavoriteListVC()
        let viewModel = FavoriteVM(persistanceManager: app.persistanceManager)
        vc.viewModel = viewModel
        viewModel.delegate = vc
        return vc
    }
}
