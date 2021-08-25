//
//  NewsFeedViewController.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 25.08.2021.
//

import UIKit

class NewsFeedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        self.title = Consts.newsFeedVCnavBarTitle
        
        navigationController?.navigationBar.barTintColor = UIColor(named: Consts.nfPurple)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
