//
//  News.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 26.08.2021.
//

import UIKit

struct News: Codable {
    
    var postId: Int
    var sourceId: Int? // Author's ID
    var date: Int
    var text: String
    var comments: Comment
    var likes: Like
    var reposts: Repost
    var attachments: [Attachment]?
    var views: Views
    var type: String
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

