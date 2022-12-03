//
//  GFFollowerInfoVC.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 26.11.2022.
//

import UIKit

protocol FollowerInfoDelegate: AnyObject {
    func requestFollowers()
}

final class GFFollowerInfoVC: GFItemInfoVC {
    
    weak var delegate: FollowerInfoDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemInfo1.set(type: .follower, count: user.followers)
        itemInfo2.set(type: .following, count: user.following)
        actionButton.set(title: "Get followers", backgroundColor: .systemGreen)
        
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    @objc private func actionButtonTapped() {
        delegate.requestFollowers()
    }


}
