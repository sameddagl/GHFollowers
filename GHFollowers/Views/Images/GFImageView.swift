//
//  GFImageView.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 25.11.2022.
//

import UIKit

class GFImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        contentMode = .scaleAspectFill
        layer.cornerRadius = 20
        layer.masksToBounds = true
        
        image = Images.placeholder
    }
    
    func set(withURL url: String) {
        NetworkLayer.shared.downloadImage(withURL: url) { image in
            if let image = image {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}