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

    @IBAction func authorizeWithVkButton(_ sender: Any) {
    }
    
    private func setAuthButtonLayout() {
        authorizationButton.layer.cornerRadius = 10
        authorizationButton.clipsToBounds = true
    }
    
}

