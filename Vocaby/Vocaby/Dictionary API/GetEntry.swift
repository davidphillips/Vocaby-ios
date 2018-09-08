//
//  GetEntry.swift
//  Vocaby
//
//  Created by David Phillips on 29/8/18.
//  Copyright © 2018 David Phillips. All rights reserved.
//

import Foundation

struct GetEntry: RequestType {
    typealias ResponseType = DictionaryWord
    var data: RequestData
}
