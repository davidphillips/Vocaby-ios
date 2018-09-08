//
//  URLSessionNetworkDispatcher.swift
//  Vocaby
//
//  Created by David Phillips on 29/8/18.
//  Copyright © 2018 David Phillips. All rights reserved.
//

import Foundation

public enum ConnError: Swift.Error {
    case invalidURL
    case noData
}

public struct URLSessionNetworkDispatcher: NetworkDispatcher {
    public static let instance = URLSessionNetworkDispatcher()
    private init() {}
    
    public func dispatch(request: RequestData, onSuccess: @escaping (Data) -> Void, onError: @escaping (Error) -> Void) {
        guard let url = URL(string: request.path) else {
            onError(ConnError.invalidURL)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        //urlRequest.httpMethod = request.method.rawValue
        
        do {
            if let params = request.params {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            }
        } catch let error {
            onError(error)
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                onError(error)
                return
            }
            
            guard let _data = data else {
                onError(ConnError.noData)
                return
            }
            
            onSuccess(_data)
            }.resume()
    }
}
