//
//  UserInfoVCBuilder.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 3.12.2022.
//

import UIKit

final class UserInfoVCBuilder {
    static func make(rootVM: FollowerListVMProtocol, with userName: String, userItSelf: Bool) -> UINavigationController{
        let vc = UserInfoVC()
        let viewModel = UserInfoVM(username: userName, userItself: userItSelf, service: app.service)
        vc.viewModel = viewModel
        viewModel.delegate = vc
        viewModel.requestFollowersDelegate = rootVM as? UserInfoDelegate
        
        let navController = UIHelper.createVCWithNavController(vc: vc)

        return navController
    }
}
