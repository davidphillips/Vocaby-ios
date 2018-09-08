//
//  NetworkDispatcher.swift
//  Vocaby
//
//  Created by David Phillips on 29/8/18.
//  Copyright © 2018 David Phillips. All rights reserved.
//

import Foundation

public protocol NetworkDispatcher {
    func dispatch(request: RequestData, onSuccess: @escaping (Data) -> Void, onError: @escaping (Error) -> Void)
}
