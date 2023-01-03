//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 25.11.2022.
//

import UIKit

final class UserInfoVC: GFDataLoadingVC {
    private let detailsContainer = UIView()
    private let itemInfo1 = UIView()
    private let itemInfo2 = UIView()
    private let dateLabel = GFTitleLabel(alignment: .center, fontSize: 14)
    
    var viewModel: UserInfoVMProtocol!
    var delegate: FollowerRequestDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureUIElements()
        layoutUI()
        viewModel.load()
    }
    
    //MARK: - Adding child vcs to view
    private func add(childVC: UIViewController, to containerView: UIView) {
        self.addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    //MARK: - Done button action
    @objc private func doneTapped() {
        dismiss(animated: true)
    }
}

//MARK: - Handle view model outputs
extension UserInfoVC: UserInfoVMDelegate {
    func handleOutput(_ output: UserInfoOutputs) {
        switch output {
        case .isLoading(let isLoading):
            isLoading ? self.showLoadingScreen() : self.dismissLoadingScreen()
        case .updateUserInfo(let user):
            self.configureUI(user: user)
        case .errorOccured(let title, let message):
            self.presentAlertVC(title: title, message: message)
        case .userItSelf(let userItSelf):
            if userItSelf {
                itemInfo2.removeFromSuperview()
                dateLabel.topAnchor.constraint(equalTo: itemInfo1.bottomAnchor, constant: 20).isActive = true
            }
        }
    }
    
    func navigate(to route: UserInfoRoute) {
        switch route {
        case .githubPage(let url):
            presentSafariVC(withURL: url)
        case .followerList(let username):
            delegate.didRequestFollowers(with: username)
            dismiss(animated: true)
        }
    }
}

//MARK: - Did select to get github page
extension UserInfoVC: RepoInfoDelegate {
    func requestGithubPage(with url: String) {
        viewModel.getGithubPage(withURL: url)
    }
}

//MARK: - Did select to get followers
extension UserInfoVC: FollowerInfoDelegate {
    func requestFollowers() {
        viewModel.getFollowers()
    }
}

//MARK: - UI Related
extension UserInfoVC {
    private func configureUI(user: UserInfoPresentation) {
        DispatchQueue.main.async {
            let repoInfoVC = GFRepoInfoVC(user: user)
            repoInfoVC.delegate = self
            
            let followerInfoVC = GFFollowerInfoVC(user: user)
            followerInfoVC.delegate = self
            
            self.add(childVC: GFInfoHeaderVC(user: user), to: self.detailsContainer)
            self.add(childVC: repoInfoVC, to: self.itemInfo1)
            self.add(childVC: followerInfoVC, to: self.itemInfo2)
            
            self.dateLabel.text = "Github since \(user.createdAt.toMonthAndYear())"
        }
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func layoutUI() {
        let padding: CGFloat = 20
        for item in [detailsContainer, itemInfo1, itemInfo2, dateLabel] {
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
            
            item.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
            item.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding).isActive = true
        }
        
        NSLayoutConstraint.activate([
            detailsContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            detailsContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.23),
            
            itemInfo1.topAnchor.constraint(equalTo: detailsContainer.bottomAnchor, constant: padding),
            itemInfo1.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.23),
            
            itemInfo2.topAnchor.constraint(equalTo: itemInfo1.bottomAnchor, constant: padding),
            itemInfo2.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.23),
            
            dateLabel.topAnchor.constraint(equalTo: itemInfo2.bottomAnchor, constant: padding)
        ])
        
    }
    
    private func configureUIElements() {
        itemInfo1.backgroundColor = .secondarySystemBackground
        itemInfo1.layer.cornerRadius = 20
        
        itemInfo2.backgroundColor = .secondarySystemBackground
        itemInfo2.layer.cornerRadius = 20
    }
    
}
