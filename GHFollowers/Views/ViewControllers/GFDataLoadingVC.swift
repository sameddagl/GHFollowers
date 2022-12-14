//
//  GFDataLoadingVC.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 25.11.2022.
//

import UIKit

class GFDataLoadingVC: UIViewController {
    private var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showLoadingScreen() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)

        containerView.backgroundColor = .black.withAlphaComponent(0.10)
        
        let ac = UIActivityIndicatorView(style: .large)
        ac.translatesAutoresizingMaskIntoConstraints = false
        ac.color = .systemGreen
        
        containerView.addSubview(ac)
        ac.center(to: containerView)
        
        ac.startAnimating()
    }
    
    func dismissLoadingScreen() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }


}
