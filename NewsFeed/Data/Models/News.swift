//
//  News.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 26.08.2021.
//

import UIKit

struct News: Codable { // items
    
    var id: Int
    var fromId: String // Author's ID
    var date: String
    var text: String
    var comments: Comment
    var likes: Like
    var reposts: Repost
    var attachments: [Attachment]?
    var views: Views
    var type: String // indicate = post
}

struct Like: Codable {
    var count: Int?
}

struct Comment: Codable {
    var count: Int?
}

struct Repost: Codable {
    var count: Int?
}

struct Views: Codable {
    var count: Int?
}

