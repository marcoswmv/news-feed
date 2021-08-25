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
    private let scope = [VK_PER_EMAIL]
    
    init(vc: UIViewController) {
        vkInstance = VKSdk.initialize(withAppId: Consts.vkAppId)
        setDelegates(for: vc)
    }
    
    func setDelegates(for vc: UIViewController) {
        vkInstance.register(vc as? VKSdkDelegate)
        vkInstance.uiDelegate = vc as? VKSdkUIDelegate
    }
    
    func authorizeWithVK(_ enabled: Bool = true) {
        if enabled {
            VKSdk.authorize(scope)
        } else {
            VKSdk.authorize(nil)
        }
    }
    
    func checkAuthorizationState(at vc: UIViewController?) {
        VKSdk.wakeUpSession(scope) { state, error in
            if state == .authorized {
                if let authVC = vc as? AuthViewController {
                    authVC.pushNewsFeedVC()
                }
            } else if let error = error {
                if let authVC = vc {
                    Alert.showErrorAlert(on: authVC, message: error.localizedDescription)
                }
            }
        }
    }
}
