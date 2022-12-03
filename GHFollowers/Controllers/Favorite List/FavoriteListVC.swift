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
        configureTableView()
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
        case .popUpUserInfoScreen(let viewModel):
            let vc = UserInfoVCBuilder.makeFromFavoriteVC(rootVC: self, with: viewModel)
            present(vc, animated: true)
        case .didRequestFollowers(let viewModel):
            dismiss(animated: true)
            let vc = FollowerListBuilder.make(with: viewModel)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension FavoriteListVC: FollowerRequestDelegate {
    func didRequestFollowers(with username: String) {
        viewModel.didRequestFollowers(username: username)
    }
}

//MARK: - UI Related
extension FavoriteListVC {
    func configureView() {
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
    }
    
    func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.register(GFFavoriteCell.self, forCellReuseIdentifier: GFFavoriteCell.reuseIdentifier)
    }
}

extension FavoriteListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GFFavoriteCell.reuseIdentifier, for: indexPath) as! GFFavoriteCell
        cell.set(favorite: favorites[indexPath.row])
        return cell
    }
}

extension FavoriteListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectItem(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

    }
}
