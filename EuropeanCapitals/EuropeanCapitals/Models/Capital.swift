//
//  Capital.swift
//  EuropeanCapitals
//
//  Created by Adrian Kaczmarek on 18/08/2020.
//

import Foundation

typealias Capitals = [Capital]

struct Capital: Codable {
    let identifier: Int
    let name: String
    let country: String
    let photoKey: String
    
    var isFavorite: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name = "city"
        case country = "country"
        case photoKey = "photo"
    }
}
