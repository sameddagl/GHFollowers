//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 25.11.2022.
//

import UIKit

class FollowerListVC: GFDataLoadingVC {
    enum Section {case main}
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    var username: String!
    
    var followers = [Follower]()
    var filteredFollowers = [Follower]()
    
    var currentPage = 1
    var hasMoreFollowers = true
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureCollectionView()
        configureDataSource()
        configureSearchController()
        fetchFollowers()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = username
    }
    
    private func fetchFollowers() {
        showLoadingScreen()
        NetworkLayer.shared.fetchFollowers(with: username, page: currentPage) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingScreen()
            switch result {
            case .success(let followers):
                if followers.count < 100 {
                    self.hasMoreFollowers = false
                }
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
        DispatchQueue.main.async {
            self.dataSource.apply(snp, animatingDifferences: true)
        }
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnLayout(view: self.view))
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a user"
            
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let height = view.frame.height
        let contentHeight = collectionView.contentSize.height
        let offset = collectionView.contentOffset.y
        
        if height + offset >= contentHeight && hasMoreFollowers {
            currentPage += 1
            fetchFollowers()
        }
    }
}

extension FollowerListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredFollowers.removeAll()
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            updateData(with: followers)
            return
        }
        filteredFollowers = followers.filter{$0.login.lowercased().contains(filter.lowercased())}
        updateData(with: filteredFollowers)
    }
}
