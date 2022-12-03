//
//  AppContainer.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 3.12.2022.
//

import Foundation

let app = AppContainer()

final class AppContainer {
    let service = NetworkLayer()
    let persistanceManager = PersistanceManager()
}
