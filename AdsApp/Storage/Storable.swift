//
//  Storable.swift
//  AdsApp
//
//  Created by Andrii Momot on 28.04.2022.
//

import Foundation

protocol Storable {
    func store<T: Codable>(_ item: T) where T: Identifiable
    func getItems<T: Decodable>() -> [T] where T: Identifiable
    func remove<T: Codable>(_ item: T) where T: Identifiable
}
