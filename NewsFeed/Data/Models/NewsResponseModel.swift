//
//  NewsResponseModel.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 26.08.2021.
//

import Foundation

struct ResponseModelContainer: Codable {
    var response: ResponseModel
}

struct ResponseModel: Codable {
    var items: NFTypes.NewsList
    var profiles: NFTypes.UsersList
    var groups: NFTypes.GroupsList
}
