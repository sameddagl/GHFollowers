//
//  FollowerListBuilder.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 2.12.2022.
//

import Foundation

final class FollowerListBuilder {
    static func make(with viewModel: FollowerListVMProtocol) -> FollowerListVC{
        let vc = FollowerListVC()
        var viewModel = viewModel

        vc.viewModel = viewModel
        viewModel.delegate = vc
        
        return vc
    }
}
