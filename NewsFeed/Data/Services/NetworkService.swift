//
//  NetworkManager.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 27.08.2021.
//

import UIKit
import Alamofire

class NetworkService {
    
    static let shared = NetworkService()
    
    private let decoder = JSONDecoder()
    
    private let baseURL: URL = URL(string: "https://api.vk.com/method")!
    
    var isPaginating: Bool = false
    
    private init() { }
    
    private func genericRequest<T: Codable>(pagination: Bool = false, url: URL, method: HTTPMethod = .get, parameters: Parameters?, completionHandler: @escaping (Result<T, AFError>) -> Void) {
        
        guard !isPaginating else { return }
        
        if pagination {
            isPaginating = true
        }
        
        let encoding = JSONEncoding.default
        
        AF.request(url, method: method, parameters: parameters, encoding: encoding).responseJSON { [weak self] response in
            guard let self = self else { return }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                if let error = response.error {
                    completionHandler(.failure(error))
                    return
                }
                
                if let data = response.data {
                    print("SUCCESS: \(data)")
                    do {
                        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let object = try self.decoder.decode(T.self, from: data)
                        completionHandler(.success(object))
                    } catch let error {
                        print(error)
                        completionHandler(.failure(.responseSerializationFailed(reason: .decodingFailed(error: error))))
                    }
                }
                
                if pagination {
                    self.isPaginating = false
                }
            }
        }
    }
}

extension NetworkService {
    
    func getPosts<T: Codable>(from nextPage: String, with pagination: Bool = false, at endpoint: EndPoint, completionHandler: @escaping (Result<T, AFError>) -> Void) {
        
        let accessToken = Account.shared.credentials?.accessToken ?? ""
        let params = "filters=post&v=5.131&count=20&start_from=\(nextPage)&access_token=\(accessToken)"
        let urlString = baseURL.absoluteString + "/" + endpoint.stringValue + "?" + params
        let url = URL(string: urlString)!
        
        genericRequest(pagination: pagination, url: url, parameters: nil, completionHandler: completionHandler)
    }
}
