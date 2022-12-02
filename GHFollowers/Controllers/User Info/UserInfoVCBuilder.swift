//
//  UserInfoVCBuilder.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 3.12.2022.
//

import UIKit

final class UserInfoVCBuilder {
    static func make(rootVC: FollowerListVC, with userName: String) -> UserInfoVC{
        let vc = UserInfoVC()
        let viewModel = UserInfoVM(username: userName, service: app.service)
        vc.viewModel = viewModel
        viewModel.delegate = vc
        viewModel.requestFollowersDelegate = rootVC
        return vc
    }
}
