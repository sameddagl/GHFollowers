//
//  GFTextField.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 25.11.2022.
//

import UIKit

final class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(placeholder: String) {
        self.init(frame: .zero)
        self.placeholder = placeholder
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .tertiarySystemBackground
        tintColor = .label
        textColor = .label
        
        font = .preferredFont(forTextStyle: .headline)
        textAlignment = .center
        
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        autocapitalizationType = .none
        clearButtonMode = .whileEditing
        returnKeyType = .search
        autocorrectionType = .no
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
