//
//  Avatar.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 26.08.2021.
//

import Foundation

struct Avatar: Codable {
    
    var id: Int
    var sizes: [AvatarSizes]
}

struct AvatarSizes: Codable {
    
    var src: String?
    var width: Int
    var height: Int
    var type: String
}
