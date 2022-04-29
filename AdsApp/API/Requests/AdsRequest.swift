//
//  AdsRequest.swift
//  AdsApp
//
//  Created by Andrii Momot on 27.04.2022.
//

import Foundation

struct AdsRequest: APIRequest {
    typealias Response = AdsResponse
    
    var path: String {
        return "baldermork/6a1bcc8f429dcdb8f9196e917e5138bd/raw/discover.json"
    }
}
