//
//  GFButton.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 25.11.2022.
//

import UIKit

final class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(title: String, backgroundColor: UIColor) {
        self.init(frame: .zero)
        set(title: title, backgroundColor: backgroundColor)

    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
        
        layer.cornerRadius = 10
    }
    
    func set(title: String, backgroundColor: UIColor) {
        setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
