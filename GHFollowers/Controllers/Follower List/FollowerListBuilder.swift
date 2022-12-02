//
//  FollowerListBuilder.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 2.12.2022.
//

import Foundation

final class FollowerListBuilder {
    static func make(with userName: String) -> FollowerListVC{
        let vc = FollowerListVC()
        let viewModel = FollowerListVM(username: userName, service: NetworkLayer())
        vc.viewModel = viewModel
        viewModel.delegate = vc
        return vc
    }
}
