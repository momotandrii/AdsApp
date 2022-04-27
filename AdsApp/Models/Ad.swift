//
//  Ad.swift
//  AdsApp
//
//  Created by Andrii Momot on 27.04.2022.
//

import Foundation

struct AdsResponse: Decodable {
    let items: [Ad]
}

struct Ad: Decodable {
    let id: String
    let title: String?
    let location: String?
    let image: Image?
    let price: Price?
    
    private enum CodingKeys : String, CodingKey {
        case id, title = "description", location, image, price
    }
}

struct Price: Decodable {
    let value: Int?
}

struct Image: Decodable {
    let url: String?
}
