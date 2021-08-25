//
//  ViewController.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 25.08.2021.
//

import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var authorizationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setAuthButtonLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        makeNavigationBarInvisible()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        makeNavigationBarVisible()
    }

    @IBAction func authorizeWithVkButton(_ sender: Any) {
        pushNewsFeedVC()
    }
    
    private func pushNewsFeedVC() {
        self.performSegue(withIdentifier: Consts.newsFeedVCstoryboardSegueId, sender: self)
    }
    
    private func setAuthButtonLayout() {
        authorizationButton.layer.cornerRadius = 10
        authorizationButton.clipsToBounds = true
    }
    
    private func makeNavigationBarInvisible() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.view.backgroundColor = .clear
        
    }
    
    private func makeNavigationBarVisible() {
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.view.backgroundColor = .white
    }
    
}

