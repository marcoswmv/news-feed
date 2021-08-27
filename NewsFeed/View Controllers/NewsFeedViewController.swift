//
//  NewsFeedViewController.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 25.08.2021.
//

import UIKit
import SwiftUI
import VKSdkFramework

class NewsFeedViewController: UIViewController {
    
    var newsTableView: UITableView!
    
    var dataSource: NewsDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNewsTableView()
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = Consts.newsFeedVCnavBarTitle
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.barTintColor = .lightishBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        let signOutButton = UIBarButtonItem(title: Consts.signOutButton, style: .plain, target: self, action: #selector(handleSignOutButton(sender:)))
        navigationItem.rightBarButtonItem = signOutButton
    }
    
    private func configureNewsTableView() {
        newsTableView = UITableView()
        newsTableView.layoutMargins = UIEdgeInsets.zero
        newsTableView.separatorInset = UIEdgeInsets.zero
        newsTableView.tableFooterView = UIView()
        
        view.addSubview(newsTableView)
        newsTableView.enableAutoLayout()
        newsTableView.register(UITableViewCell.self, forCellReuseIdentifier: Consts.newsTableViewCellId)
        newsTableView.setConstraints(to: view)
        
        setupDataSource()
    }
    
    private func setupDataSource() {
        dataSource = NewsDataSource(tableView: newsTableView)
        dataSource?.reload()
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

struct NewsFeedViewController_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            UINavigationController(rootViewController: NewsFeedViewController())
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }
}
