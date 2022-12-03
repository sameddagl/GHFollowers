//
//  UserInfoVCBuilder.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 3.12.2022.
//

import UIKit

final class UserInfoVCBuilder {
    static func make(rootVC: FollowerListVC, with viewModel: UserInfoVMProtocol) -> UINavigationController{
        let vc = UserInfoVC()
        
        var viewModel = viewModel
        vc.delegate = rootVC
        vc.viewModel = viewModel
        viewModel.delegate = vc
        
        let navController = UIHelper.createVCWithNavController(vc: vc)

        return navController
    }
    
    static func makeFromFavoriteVC(rootVC: FavoriteListVC, with viewModel: UserInfoVMProtocol) -> UINavigationController{
        let vc = UserInfoVC()
        
        var viewModel = viewModel
        vc.delegate = rootVC
        vc.viewModel = viewModel
        viewModel.delegate = vc
        
        let navController = UIHelper.createVCWithNavController(vc: vc)

        return navController
    }
}
