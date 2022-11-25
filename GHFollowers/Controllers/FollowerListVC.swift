//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 25.11.2022.
//

import UIKit

class FollowerListVC: UIViewController {
    enum Section {case main}
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    var username: String!
    
    var followers = [Follower]()
    
    var currentPage = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureCollectionView()
        configureDataSource()
        fetchFollowers()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = username
    }
    
    private func fetchFollowers() {
        NetworkLayer.shared.fetchFollowers(with: username, page: currentPage) { result in
            switch result {
            case .success(let followers):
                self.followers.append(contentsOf: followers)
                self.updateData(with: self.followers)
            case .failure(let error):
                self.presentAlertVC(title: "An error occured", message: error.rawValue)
            }
        }
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(title: follower.login, avatarURL: follower.avatarUrl)
            return cell
        })
    }
    
    private func updateData(with followers: [Follower]) {
        var snp = NSDiffableDataSourceSnapshot<Section, Follower>()
        snp.appendSections([.main])
        snp.appendItems(followers)
        dataSource.apply(snp, animatingDifferences: true)
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnLayout(view: self.view))
        view.addSubview(collectionView)
        
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
}
