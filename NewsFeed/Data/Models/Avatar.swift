//
//  Avatar.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 26.08.2021.
//

import Foundation

struct Avatar: Codable {
    
    var id: Int
    var sizes: AvatarSizes
}

struct AvatarSizes: Codable {
    
    var src: String
    var width: Int
    var height: Int
    var type: String // indicate = s
}

//sizes: [{
//src: http://cs323930.vk.me/v323930021/53f7/OwV0l2YFJ7s.jpg
//width: 75,
//height: 50,
//type: 's'
//} ...]
