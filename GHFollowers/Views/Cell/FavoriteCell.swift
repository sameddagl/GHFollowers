//
//  FavoriteCell.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 3.12.2022.
//

import UIKit

class GFFavoriteCell: UITableViewCell {
    static let reuseIdentifier = "FavoriteCell"
    private let avatarImageView = GFImageView(service: AppContainer.service)
    private let title = GFTitleLabel(alignment: .left, fontSize: 25)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBackground
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Set Function
    func set(favorite: FavoriteListPresentation) {
        title.text = favorite.username
        avatarImageView.set(withURL: favorite.avatarURL)
    }
    
    //MARK: - Configure UI Elements
    private func configure() {
        let padding: CGFloat = 20
        addSubview(avatarImageView)
        addSubview(title)
        
        accessoryType = .disclosureIndicator
        
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }


}
