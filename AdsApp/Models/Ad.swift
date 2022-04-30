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

protocol Identifiable {
    var id: String { get }
}

// Ad is a class because we need to update isFavourite from local database separate
class Ad: Codable, Identifiable, Equatable {
    static func == (lhs: Ad, rhs: Ad) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: String
    let title: String?
    let location: String?
    let image: Image?
    let price: Price?
    var isFavourite: Bool = false
    
    private enum CodingKeys : String, CodingKey {
        case id, title = "description", location, image, price
    }
}

struct Price: Codable {
    let value: Double?
    
    var formattedValue: String? {
        return value?.convertToCurrency()
    }
}

struct Image: Codable {
    let url: String?
    
    var fullParh: String? {
        guard let url = url else { return nil}
        return "https://images.finncdn.no/dynamic/480x360c/\(url)"
    }
}
