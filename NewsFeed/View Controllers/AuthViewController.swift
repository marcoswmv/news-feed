//
//  ViewController.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 25.08.2021.
//

import UIKit
import VKSdkFramework

class AuthViewController: UIViewController {

    private var authorizationButton: UIButton!
    
    private var authManager: AuthManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setAuthButton()
        setAuthorization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        makeNavigationBarInvisible()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        makeNavigationBarVisible()
    }
    
    func setAuthorization() {
        authManager = AuthManager(vc: self)
        authManager?.checkAuthorizationState(at: self)
    }
    
    private func setAuthButton() {
        authorizationButton = UIButton()
        authorizationButton.setTitle(Consts.authButtonTitle, for: .normal)
        authorizationButton.backgroundColor = UIColor(named: Consts.nfPurple)
        authorizationButton.layer.cornerRadius = 10
        authorizationButton.clipsToBounds = true
        
        view.addSubview(authorizationButton)
        
        authorizationButton.enableAutoLayout()
        authorizationButton.setHeightConstraint(height: 50)
        authorizationButton.setHorizontalConstraints(to: view, leading: 30, trailing: -30)
        authorizationButton.setVerticalCenterConstraint(to: view)
        
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationWithVk(sender:)), for: .touchUpInside)
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
    
    func pushNewsFeedVC() {
        let newsFeedVC = NewsFeedViewController()
        navigationController?.pushViewController(newsFeedVC, animated: true)
    }
    
    @objc func handleAuthorizationWithVk(sender: UIButton) {
        authManager?.authorizeWithVK()
    }
}

extension AuthViewController: VKSdkDelegate {
    func vkSdkTokenHasExpired(_ expiredToken: VKAccessToken!) {
        authManager?.authorizeWithVK(false)
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if let token = result.token {
            print("[VK - SUCCESS]")
            let crecentials = Credentials(credentials: token)
            Account.shared.setCredentials(crecentials)
            pushNewsFeedVC()
        } else if let error = result.error {
            Alert.showBasicAlert(on: self, title: Consts.accessDeniedTitle, message: error.localizedDescription)
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        Alert.showBasicAlert(on: self, title: Consts.accessDeniedTitle)
    }
}

extension AuthViewController: VKSdkUIDelegate {
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        if let rootVC = UIApplication.topViewController() {
            rootVC.present(controller, animated: true)
        }
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        let viewController = VKCaptchaViewController.captchaControllerWithError(captchaError)
        viewController?.present(in: UIApplication.topViewController())
    }
}
