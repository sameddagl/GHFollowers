//
//  GFBodyLabel.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 25.11.2022.
//

import UIKit

final class GFBodyLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(alingment: NSTextAlignment) {
        self.init(frame: .zero)
        textAlignment = alingment
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        textColor = .label
        font = .preferredFont(forTextStyle: .body)
        
        numberOfLines = 0
        lineBreakMode = .byTruncatingTail
        
        minimumScaleFactor = 0.6
        adjustsFontSizeToFitWidth = true
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
