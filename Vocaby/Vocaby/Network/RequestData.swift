//
//  RequestData.swift
//  Vocaby
//
//  Created by David Phillips on 29/8/18.
//  Copyright © 2018 David Phillips. All rights reserved.
//

import Foundation

public struct RequestData {
    public let path: String
    //public let method: httpMethod
    public let params: [String: Any?]?
    public let headers: [String: String]?
    
    public init (
        path: String,
        //method: URLRequest.Type = .get,
        params: [String: Any?]? = nil,
        headers: [String: String]? = nil
        ) {
        self.path = path
        //self.method = method
        self.params = params
        self.headers = headers
    }
}
