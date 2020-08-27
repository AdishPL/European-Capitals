//
//  CityInfo.swift
//  EuropeanCapitals
//
//  Created by Adrian Kaczmarek on 21/08/2020.
//

import Foundation

struct CityInfo: Codable {
    let about: String
    
    private enum CodingKeys: String, CodingKey {
        case about = "details"
    }
}
