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
    
    private init() { }
    
    @discardableResult
    private func genericRequest<T: Codable>(url: URL, method: HTTPMethod = .get, parameters: Parameters?, completionHandler: @escaping (Result<T, AFError>) -> Void) -> DataRequest {
        
        let encoding = JSONEncoding.default
        
        return AF.request(url, method: method, parameters: parameters, encoding: encoding).responseJSON { [weak self] response in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                
                if let error = response.error {
                    completionHandler(.failure(error))
                    return
                }
                
                if let data = response.data {
                    do {
                        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let object = try self.decoder.decode(T.self, from: data)
                        completionHandler(.success(object))
                    } catch let error {
                        completionHandler(.failure(.responseSerializationFailed(reason: .decodingFailed(error: error))))
                    }
                }
            }
        }
    }
}

extension NetworkService {
    
    @discardableResult
    func getPosts<T: Codable>(endpoint: EndPoint, completionHandler: @escaping (Result<T, AFError>) -> Void) -> DataRequest {
        
        let accessToken = Account.shared.credentials?.accessToken ?? ""
        let params = "filters=post&v=5.131&access_token=\(accessToken)"
        let urlString = baseURL.absoluteString + "/" + endpoint.stringValue + "?" + params
        let url = URL(string: urlString)!
        
        return genericRequest(url: url, parameters: nil, completionHandler: completionHandler)
    }
}
