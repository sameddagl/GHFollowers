//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 25.11.2022.
//

import UIKit

final class SearchVC: UIViewController {
    private let logoImageView = UIImageView()
    private let userNameTextField = GFTextField(placeholder: "Search for a user")
    private let actionButton = GFButton(title: "Search", backgroundColor: .systemGreen)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        layoutViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: - Go to followers age
    private func goToFollowersPage() {
        guard let username = userNameTextField.text, !username.isEmpty else {
            presentAlertVC(title: "No username", message: "Please enter a username.")
            return
        }
        
        userNameTextField.resignFirstResponder()
        
        let vc = FollowerListBuilder.make(with: username)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - UI
    private func layoutViews() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(userNameTextField)
        userNameTextField.delegate = self
        userNameTextField.text = "SAllen0400"
        
        view.addSubview(actionButton)
        
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        logoImageView.image = Images.logo
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            
            userNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50),
            userNameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            actionButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            actionButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc func actionButtonTapped() {
        goToFollowersPage()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
    }
}

//MARK: - Pressed on return key
extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        goToFollowersPage()
        return true
    }
}

