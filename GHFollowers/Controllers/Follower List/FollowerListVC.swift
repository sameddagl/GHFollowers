//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 25.11.2022.
//

import UIKit

class FollowerListVC: GFDataLoadingVC {
    enum Section {case main}
    
    var viewModel: FollowerListVMProtocol!
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, FollowerListPresentation>!
    
    var followers = [FollowerListPresentation]()
    var filteredFollowers = [FollowerListPresentation]()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureCollectionView()
        configureDataSource()
        configureSearchController()
        viewModel.load()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        configureNavBar()
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, FollowerListPresentation>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(title: follower.login, avatarURL: follower.avatarUrl)
            return cell
        })
    }
    
    private func updateData(with followers: [FollowerListPresentation]) {
        var snp = NSDiffableDataSourceSnapshot<Section, FollowerListPresentation>()
        snp.appendSections([.main])
        snp.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snp, animatingDifferences: true)
        }
    }
    
    @objc private func getUserInfo() {
        viewModel.getUserInfo()
    }
    
    @objc private func favoriteUser() {
        viewModel.saveUserTapped()
    }
}

//MARK: - View Model Outputs
extension FollowerListVC: FollowerListDelegate {
    func handleOutputs(_ output: FollowerListOutputs) {
        switch output {
        case .updateTitle(let title):
            self.title = title
        case .isLoading(let isLoading):
            isLoading ? self.showLoadingScreen() : self.dismissLoadingScreen()
        case .updateFollowers(let followers):
            self.followers = followers
            self.updateData(with: self.followers)
        case .scrollToTop:
            DispatchQueue.main.async {
                self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            }
        case .updateSearchResults(let filteredFollowers):
            self.filteredFollowers = filteredFollowers
            self.updateData(with: self.filteredFollowers)
        case .throwAlert(let title, let message):
            self.presentAlertVC(title: title, message: message)
        }
    }
    
    //MARK: - Navigation
    func navigate(to route: FollowerListRoute) {
        switch route {
        case .userInfo(let rootVM, let username, let userItSelf):
            let vc = UserInfoVCBuilder.make(rootVM: rootVM, with: username, userItSelf: userItSelf)
            present(vc, animated: true)
        }
    }
}

//MARK: - Collection View Delegate
extension FollowerListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let height = view.frame.height
        let contentHeight = collectionView.contentSize.height
        let offset = collectionView.contentOffset.y
        
        viewModel.pagination(height: height, contentHeight: contentHeight, offset: offset)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.getUserInfo(at: indexPath.item)
    }
}

//MARK: - Searching update
extension FollowerListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchForUser(filter: searchController.searchBar.text)
    }
}


//MARK: - UI Related
extension FollowerListVC {
    private func configureView() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureNavBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        let infoButton = UIBarButtonItem(image: UIImage(systemName: SFSymbols.info), style: .done, target: self, action: #selector(getUserInfo))
        
        let favoriteButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(favoriteUser))
        navigationItem.rightBarButtonItems = [favoriteButton, infoButton]
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
