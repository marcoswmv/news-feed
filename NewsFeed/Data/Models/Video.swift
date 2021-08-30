//
//  Video.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 26.08.2021.
//

import Foundation

struct Video: Codable {
    var id: Int
    var duration: Int? // in seconds
    var ownerId: Int?
    var image: NFTypes.VideoImages?
    var trackCode: String?
    
    // https://vk.com/dev/objects/video TO-DO: check video URL info
}

struct VideoImage: Codable {
    var withPadding: Int?
    var height: Int?
    var url: String?
    var width: Int?
}
