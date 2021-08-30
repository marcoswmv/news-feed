//
//  ImageService.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 27.08.2021.
//

import Foundation
import Kingfisher

class ImageService {
    
    static let shared = ImageService()
    
    private init() { }
    
    @discardableResult
    func getImage(with urlString: String, completionHandler: @escaping NFTypes.ImageResponse) -> KF.Builder {
        
        let url = URL(string: urlString)
        
        return KF.url(url)
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .onSuccess { result in
                completionHandler(.success(result))
            }
            .onFailure { error in
                completionHandler(.failure(error))
            }
    }
    
}
