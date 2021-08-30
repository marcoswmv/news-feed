//
//  Avatar.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 26.08.2021.
//

import Foundation

struct Photo: Codable {
    
    var id: Int
    var sizes: NFTypes.PhotoSizes
}

struct PhotoSize: Codable {
    
    var url: String?
    var width: Int
    var height: Int
    var type: String
}
