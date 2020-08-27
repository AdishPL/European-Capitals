//
//  CapitalDetails.swift
//  EuropeanCapitals
//
//  Created by Adrian Kaczmarek on 21/08/2020.
//

import Foundation

struct CapitalDetails: Codable {
    let population: String
    let timeZone: String
    let area: String
    
    private enum CodingKeys: String, CodingKey {
        case population = "population"
        case timeZone = "tz"
        case area = "area"
    }
}
