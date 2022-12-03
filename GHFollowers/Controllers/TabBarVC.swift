//
//  TabBarVC.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 25.11.2022.
//

import UIKit

final class TabBarVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().tintColor = .systemGreen
        UITabBar.appearance().tintColor = .systemGreen
        
        viewControllers = [createSearchVCNavController(), createFavoritesVCNavController()]
    }
    
    private func createSearchVCNavController() -> UINavigationController {
        let vc = SearchVC()
        let navController = UINavigationController(rootViewController: vc)
        
        navController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return navController
    }
    
    private func createFavoritesVCNavController() -> UINavigationController {
        let vc = FavoriteListBuilder.make()
        let navController = UINavigationController(rootViewController: vc)
        
        navController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return navController
    }
}
