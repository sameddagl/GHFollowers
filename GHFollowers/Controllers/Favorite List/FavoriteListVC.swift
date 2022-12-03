//
//  FavoriteListVC.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 25.11.2022.
//

import UIKit

final class FavoriteListVC: GFDataLoadingVC {
    var tableView: UITableView!
    
    var viewModel: FavoriteListVMProtocol!
    
    private var favorites = [FavoriteListPresentation]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModel.load()
    }
}

extension FavoriteListVC: FavoriteListVMDelegate {
    func handleOutput(_ output: FavoriteListOutputs) {
        switch output {
        case .updateData(let favorites):
            self.favorites = favorites
            print(self.favorites)
        case .errorOccured(let title, let message):
            self.presentAlertVC(title: title, message: message)
        }
    }
}

//MARK: - UI Related
extension FavoriteListVC {
    func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    func configureTableView() {
        tableView = UITableView(frame: view.bounds)
    }
}
