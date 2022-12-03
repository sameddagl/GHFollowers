//
//  GFRepoInfoVC.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 26.11.2022.
//

import UIKit

protocol RepoInfoDelegate: AnyObject {
    func requestGithubPage(with url: String)
}

final class GFRepoInfoVC: GFItemInfoVC {
    
    weak var delegate: RepoInfoDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemInfo1.set(type: .repo, count: user.publicRepos)
        itemInfo2.set(type: .gist, count: user.publicGists)
        actionButton.set(title: "Github page", backgroundColor: .systemPurple)
        
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    @objc func actionButtonTapped() {
        delegate.requestGithubPage(with: user.htmlUrl)
    }

}
