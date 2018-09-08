//
//  GetEntryUseCase.swift
//  Vocaby
//
//  Created by David Phillips on 12/8/18.
//  Copyright © 2018 David Phillips. All rights reserved.
//

import Foundation

class GetEntryUseCase {
    
    //var data = RequestData.init(path: <#T##String#>, method: <#T##URLRequest.Type#>, params: <#T##[String : Any?]?#>, headers: <#T##[String : String]?#>)

    
    func request(data: RequestData) {
        GetEntry.init(data: data).execute(
            onSuccess: { (dictionaryWord: DictionaryWord) in
                // Do something with the users. They are already typed!
        },
            onError: { (error: Error) in
                // Do something with the error.
        })
    }
    
    /*
    func request() {
        let session = URLSession.shared
        _ = session.dataTask(with: request, completionHandler: { data, response, error in
            if let response = response,
                let data = data,
                let jsonData = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                print(response)
                print(jsonData)
            } else {
                print(error)
                print(NSString.init(data: data!, encoding: String.Encoding.utf8.rawValue))
            }
        }).resume()
    }
 */
 
    
}
