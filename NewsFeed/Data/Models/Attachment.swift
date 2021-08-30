//
//  Attachment.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 26.08.2021.
//

import Foundation

struct Attachment: Codable {
    var type: String
    var photo: Photo?
    var video: Video?
}
