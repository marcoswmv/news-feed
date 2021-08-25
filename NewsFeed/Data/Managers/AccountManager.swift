//
//  AccountManager.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 25.08.2021.
//

import Foundation

class Account {
    
    static let shared = Account()
    
    // Best practice would be use Keychain for security porpuses.
    // Using UserDefaults just as quick and simple solution, although not the best.
    @UserDefault(Consts.accountCredentials, defaultValue: nil)
    private(set) var credentials: Credentials?
    
    var isLogged: Bool {
        return credentials != nil
    }
    
    private init() { }
    
    func setCredentials(_ credentials: Credentials) {
        self.credentials = credentials
    }
    
    func signOut() {
        credentials = nil
    }
    
}
