//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 25.11.2022.
//

import UIKit

protocol UserInfoDelegate: AnyObject {
    func didRequestFollowers(with username: String)
}

class UserInfoVC: GFDataLoadingVC {
    let detailsContainer = UIView()
    let itemInfo1 = UIView()
    let itemInfo2 = UIView()
    let dateLabel = GFTitleLabel(alignment: .center, fontSize: 14)
    
    var username: String!
    var userItSelf: Bool!
    
    weak var delegate: UserInfoDelegate!
    
    init(username: String!, userItSelf: Bool, delegate: UserInfoDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        self.userItSelf = userItSelf
        self.delegate = delegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureUIElements()
        layoutUI()
        getUserInfo()
    }
    
    //MARK: - Network call to get user info
    private func getUserInfo() {
        showLoadingScreen()
        NetworkLayer.shared.fetchUserInfo(with: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingScreen()
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUI(user: user)
                }
            case .failure(let error):
                self.presentAlertVC(title: "An error occured", message: error.rawValue)
            }
        }
    }

    //MARK: - Adding child vcs to view
    private func add(childVC: UIViewController, to containerView: UIView) {
        self.addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    //MARK: - Button action
    @objc func doneTapped() {
        dismiss(animated: true)
    }
    
    //MARK: - UI Related
    private func configureUI(user: User) {
        let repoInfoVC = GFRepoInfoVC(user: user)
        repoInfoVC.delegate = self
        
        let followerInfoVC = GFFollowerInfoVC(user: user)
        followerInfoVC.delegate = self
        
        DispatchQueue.main.async {
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

        ])
        
        if userItSelf {
            itemInfo2.removeFromSuperview()
            dateLabel.topAnchor.constraint(equalTo: itemInfo1.bottomAnchor, constant: padding).isActive = true
        }
        
        else {
            itemInfo2.topAnchor.constraint(equalTo: itemInfo1.bottomAnchor, constant: padding).isActive = true
            itemInfo2.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.23).isActive = true
            
            dateLabel.topAnchor.constraint(equalTo: itemInfo2.bottomAnchor, constant: padding).isActive = true
        }
    }
    
    private func configureUIElements() {
        itemInfo1.backgroundColor = .secondarySystemBackground
        itemInfo1.layer.cornerRadius = 20
        
        itemInfo2.backgroundColor = .secondarySystemBackground
        itemInfo2.layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UserInfoVC: GFRepoInfoDelegate {
    func didRequestGithubPage(withURL url: String) {
        presentSafariVC(withURL: url)
    }
}

extension UserInfoVC: GFFollowerInfoDelegate {
    func didRequestFollowers(with username: String) {
        dismiss(animated: true)
        delegate.didRequestFollowers(with: username)
    }
}
