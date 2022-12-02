//
//  GFItemInfoVC.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 26.11.2022.
//

import UIKit

class GFItemInfoVC: UIViewController {
    let itemInfo1 = GFItemInfo(frame: .zero)
    let itemInfo2 = GFItemInfo(frame: .zero)
    let actionButton = GFButton(frame: .zero)
    
    var user: User!
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()

    }
    
    private func configure() {
        let stack = UIStackView(arrangedSubviews: [itemInfo1, itemInfo2])
        stack.alignment = .top
        stack.distribution = .equalSpacing
        
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 15
        
        NSLayoutConstraint.activate([
            stack.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor, multiplier: 0.5),
            stack.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            
            actionButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.27),
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
