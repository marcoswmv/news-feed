//
//  Alert.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 06.08.2021.
//

import UIKit

struct Alert {
    static func showBasicAlert(on viewController: UIViewController, style: UIAlertController.Style = .alert, title: String? = nil, message: String? = nil, actions: [UIAlertAction] = [UIAlertAction(title: Consts.okButton, style: .cancel, handler: nil)], completion: (() -> Void)? = nil) {
        
        let alert =  UIAlertController(title: title, message: message, preferredStyle: style)
        
        for action in actions { alert.addAction(action) }
        DispatchQueue.main.async { viewController.present(alert, animated: true, completion: completion) }
    }
    
    static func showErrorAlert(on viewController: UIViewController, message: String) {
        showBasicAlert(on: viewController,
                       style: .alert,
                       title: Consts.errorTitle,
                       message: message)
    }
}
