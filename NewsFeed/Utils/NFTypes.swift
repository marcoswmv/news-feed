//
//  NFTypes.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 26.08.2021.
//

import Foundation
import Kingfisher

struct NFTypes {
    
    typealias PostsList = [Post]
    typealias UsersList = [User]
    typealias GroupsList = [Group]
    typealias PhotosList = [String: Photo]
    typealias VideosList = [String: Video]
    
    typealias ImageResponse = (Result<RetrieveImageResult, KingfisherError>) -> Void
}
