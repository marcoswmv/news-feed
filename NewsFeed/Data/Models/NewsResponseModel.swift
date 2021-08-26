//
//  NewsResponseModel.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 26.08.2021.
//

import Foundation

struct ResponseModel: Codable {
    var items: [News]
    var profiles: [User]
}
