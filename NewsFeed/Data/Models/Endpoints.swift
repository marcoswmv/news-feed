//
//  Endpoints.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 27.08.2021.
//

import Foundation

enum EndPoint {
    
    case newsfeed
    case accountInfo
    
    var stringValue: String {
        switch self {
        case .newsfeed:
            return "newsfeed.get"
        case .accountInfo:
            return "account.getProfileInfo"
        }
    }
}
