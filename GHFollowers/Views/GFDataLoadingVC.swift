//
//  GFDataLoadingVC.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 25.11.2022.
//

import UIKit

class GFDataLoadingVC: UIViewController {
    var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func showLoadingScreen() {
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        containerView.pinTo(view: self.view)

        containerView.backgroundColor = .black.withAlphaComponent(0.25)
        
        let ac = UIActivityIndicatorView(style: .medium)
        ac.translatesAutoresizingMaskIntoConstraints = false
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
