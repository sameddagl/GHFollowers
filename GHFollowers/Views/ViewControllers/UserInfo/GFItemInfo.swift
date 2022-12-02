//
//  GFItemInfo.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 26.11.2022.
//

import UIKit

final class GFItemInfo: UIView {
    enum ItemType {
        case repo
        case gist
        case follower
        case following
    }
    
    let iconImageView = UIImageView(frame: .zero)
    let titleLabel = GFTitleLabel(alignment: .left, fontSize: 15)
    let countLabel = GFTitleLabel(alignment: .center, fontSize: 15)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    private func configure() {
        let topStack = UIStackView(arrangedSubviews: [iconImageView, titleLabel])
        topStack.spacing = 5
        topStack.distribution = .fill
        topStack.alignment = .center
        
        iconImageView.tintColor = .label
        
        let mainStack = UIStackView(arrangedSubviews: [topStack, countLabel])
        mainStack.axis = .vertical
        mainStack.distribution = .fillEqually
        mainStack.alignment = .center
        
        addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.pinTo(view: self)
    }
    
    func set(type: ItemType, count: Int) {
        switch type {
        case .repo:
            iconImageView.image = UIImage(systemName: SFSymbols.repo)
            titleLabel.text = "Public repos"
        case .gist:
            iconImageView.image = UIImage(systemName: SFSymbols.gists)
            titleLabel.text = "Public gists"
        case .follower:
            iconImageView.image = UIImage(systemName: SFSymbols.followers)
            titleLabel.text = "Followers"
        case .following:
            iconImageView.image = UIImage(systemName: SFSymbols.following)
            titleLabel.text = "Following"
        }
        countLabel.text = String(count)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
