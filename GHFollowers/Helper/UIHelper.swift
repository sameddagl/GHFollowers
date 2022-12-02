//
//  UIHelper.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 25.11.2022.
//

import UIKit

struct UIHelper {
    static func createThreeColumnLayout(view: UIView) -> UICollectionViewFlowLayout {
        let width = view.frame.width
        let padding: CGFloat = 10
        let itemSpacing: CGFloat = 10
        
        let availableWidth = width - (padding * 2) - (itemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        layout.itemSize = .init(width: itemWidth, height: itemWidth + 50)
        return layout
    }
    
    static func createVCWithNavController(vc: UIViewController) -> UINavigationController {
        let navController = UINavigationController(rootViewController: vc)
        let appereance = UINavigationBarAppearance()
        appereance.configureWithDefaultBackground()
        navController.navigationBar.standardAppearance = appereance
        navController.navigationBar.scrollEdgeAppearance = appereance
        return navController
    }
}
