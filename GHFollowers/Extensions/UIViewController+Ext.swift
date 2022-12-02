//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 25.11.2022.
//

import UIKit
import SafariServices

extension UIViewController {
    func presentAlertVC(title: String, message: String) {
        DispatchQueue.main.async {
            let vc = GFAlertVC(title: title, message: message)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true)
        }
    }
    
    func presentSafariVC(withURL url: String) {
        guard let url = URL(string: url) else { return }
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        
        present(safariVC, animated: true)
    }

}
