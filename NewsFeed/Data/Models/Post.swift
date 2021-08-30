//
//  Post.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 29.08.2021.
//

import Foundation

struct Post: Codable {
    
    var postId: Int?
    var sourceId: Int? // Author's ID
    var date: Int
    var text: String
    var comments: Comment?
    var likes: Like?
    var reposts: Repost?
    var attachments: NFTypes.Attachments?
    var views: Views?
    var type: String?
    var copyHistory: NFTypes.PostsList?
    
    static var mocked = Post(postId: 0, sourceId: 0, date: 0, text: "", comments: Comment(count: 0), likes: Like(count: 0), reposts: Repost(count: 0), views: Views(count: 0), type: "")
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
