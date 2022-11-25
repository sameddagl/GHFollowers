//
//  GFTitleLabel.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 25.11.2022.
//

import UIKit

final class GFTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(alignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        textAlignment = alignment
        font = .systemFont(ofSize: fontSize, weight: .bold)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        textColor = .label
        numberOfLines = 1
        lineBreakMode = .byTruncatingTail
        
        minimumScaleFactor = 0.9
        adjustsFontSizeToFitWidth = true
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
