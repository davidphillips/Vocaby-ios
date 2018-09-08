//
//  RequestType+execute.swift
//  Vocaby
//
//  Created by David Phillips on 29/8/18.
//  Copyright © 2018 David Phillips. All rights reserved.
//

import Foundation

public extension RequestType {
    public func execute (
        dispatcher: NetworkDispatcher = URLSessionNetworkDispatcher.instance,
        onSuccess: @escaping (ResponseType) -> Void,
        onError: @escaping (Error) -> Void
        ) {
        dispatcher.dispatch(
            request: self.data,
            onSuccess: { (responseData: Data) in
                do {
                    let jsonDecoder = JSONDecoder()
                    let result = try jsonDecoder.decode(ResponseType.self, from: responseData)
                    DispatchQueue.main.async {
                        onSuccess(result)
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        onError(error)
                    }
                }
        },
            onError: { (error: Error) in
                DispatchQueue.main.async {
                    onError(error)
                }
        }
        )
    }
}
