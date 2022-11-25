//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 25.11.2022.
//

import UIKit

extension UIViewController {
    func presentAlertVC(title: String, message: String) {
        let vc = GFAlertVC(title: title, message: message)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        DispatchQueue.main.async {
            self.present(vc, animated: true)
        }
    }
    
    func dismissAlertVC() {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
}
