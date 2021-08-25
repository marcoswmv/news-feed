//
//  NewsFeedViewController.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 25.08.2021.
//

import UIKit
import VKSdkFramework

class NewsFeedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = Consts.newsFeedVCnavBarTitle
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.barTintColor = UIColor(named: Consts.nfPurple)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        let signOutButton = UIBarButtonItem(title: Consts.signOutButton, style: .plain, target: self, action: #selector(handleSignOutButton(sender:)))
        navigationItem.rightBarButtonItem = signOutButton
    }
    
    @objc func handleSignOutButton(sender: UIButton) {
        Account.shared.signOut()
        VKSdk.forceLogout()
        if navigationController?.viewControllers.count == 1,
           navigationController?.viewControllers.first is NewsFeedViewController {
            let authVC = AuthViewController()
            navigationController?.viewControllers.insert(authVC, at: 0)
        }
        navigationController?.popViewController(animated: true)
    }
}
