//
//  AuthManager.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 25.08.2021.
//

import UIKit
import VKSdkFramework

class AuthManager {
    
    private var vkInstance: VKSdk
    private let scope = [VK_PER_EMAIL, VK_PER_WALL, VK_PER_FRIENDS]
    
    init(viewController: UIViewController) {
        vkInstance = VKSdk.initialize(withAppId: Consts.vkAppId)
        setDelegates(for: viewController)
    }
    
    func setDelegates(for viewController: UIViewController) {
        vkInstance.register(viewController as? VKSdkDelegate)
        vkInstance.uiDelegate = viewController as? VKSdkUIDelegate
    }
    
    func authorizeWithVK(_ enabled: Bool = true) {
        if enabled {
            VKSdk.authorize(scope)
        } else {
            VKSdk.authorize(nil)
        }
    }
    
    func checkAuthorizationState(at viewController: UIViewController?) {
        VKSdk.wakeUpSession(scope) { state, error in
            if state == .authorized {
                if let authViewController = viewController as? AuthViewController {
                    authViewController.pushNewsFeedVC()
                }
            } else if let error = error {
                if let authviewController = viewController {
                    Alert.showErrorAlert(on: authviewController, message: error.localizedDescription)
                }
            }
        }
    }
}
