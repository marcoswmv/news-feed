//
//  Credentials.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 25.08.2021.
//

import Foundation
import VKSdkFramework

class Credentials: NSObject, NSCoding {
    
    var userId: String
    var email: String
    var accessToken: String
    var creationDate: TimeInterval
    var expirationDate: Int
    
    init(credentials: VKAccessToken) {
        self.userId = credentials.userId
        self.email = credentials.email
        self.accessToken = credentials.accessToken
        self.creationDate = credentials.created
        self.expirationDate = credentials.expiresIn
    }
    
    required init?(coder: NSCoder) {
        self.userId = coder.decodeObject(forKey: "userId") as? String ?? ""
        self.email = coder.decodeObject(forKey: "email") as? String ?? ""
        self.accessToken = coder.decodeObject(forKey: "accessToken") as? String ?? ""
        self.creationDate = coder.decodeObject(forKey: "creationDate") as? TimeInterval ?? TimeInterval()
        self.expirationDate = coder.decodeObject(forKey: "expirationDate") as? Int ?? 0
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(userId, forKey: "userId")
        coder.encode(email, forKey: "email")
        coder.encode(accessToken, forKey: "accessToken")
        coder.encode(creationDate, forKey: "creationDate")
        coder.encode(expirationDate, forKey: "expirationDate")
    }
}
