//
//  GFInfoHeaderVC.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 25.11.2022.
//

import UIKit

final class GFInfoHeaderVC: UIViewController {
    private let avatarImageView = GFImageView(service: AppContainer.service)
    private let usernameLabel = GFTitleLabel(alignment: .left, fontSize: 20)
    private let nameLabel = GFSecondaryLabel(alingment: .left)
    private let locationImageView = UIImageView()
    private let locationLabel = GFSecondaryLabel(alingment: .left)
    private let bioLabel = GFSecondaryLabel(alingment: .left)

    private var user: UserInfoPresentation!
    
    init(user: UserInfoPresentation!) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
        configureUI()
        setInfos()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configureUI() {
        locationImageView.tintColor = .secondaryLabel
        
        let locationStack = UIStackView(arrangedSubviews: [locationImageView, locationLabel])
        locationStack.alignment = .center
        locationStack.distribution = .fill
        locationStack.spacing = 8
        
        let titlesStack = UIStackView(arrangedSubviews: [usernameLabel, nameLabel, locationStack])
        titlesStack.axis = .vertical
        titlesStack.distribution = .fillEqually
        titlesStack.spacing = 0
        
        let mainStack = UIStackView(arrangedSubviews: [avatarImageView, titlesStack])
        mainStack.distribution = .fill
        mainStack.spacing = 20

        
        view.addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bioLabel)
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        bioLabel.numberOfLines = 3
        
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            locationImageView.widthAnchor.constraint(equalToConstant: 18),
            locationImageView.heightAnchor.constraint(equalToConstant: 18),
            
            
            mainStack.topAnchor.constraint(equalTo: view.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            bioLabel.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 10),
            bioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -10)
        ])
    }

    
    private func setInfos() {
        avatarImageView.set(withURL: user.avatarUrl)
        
        usernameLabel.text = user.login
        nameLabel.text = user.name
        locationImageView.image = UIImage(systemName: SFSymbols.location)
        locationLabel.text = user.location ?? "No location available"
        bioLabel.text = user.bio ?? "No bio available"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    


}
