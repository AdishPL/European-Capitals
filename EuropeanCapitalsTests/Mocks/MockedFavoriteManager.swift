//
//  MockedFavoriteManager.swift
//  EuropeanCapitalsTests
//
//  Created by Adrian Kaczmarek on 25/08/2020.
//

import Foundation
@testable import EuropeanCapitals

class MockedFavoritesManager: FavoritesManagerProtocol {
    var favorites: [Int] = []
    
    func toggleFavorite(_ identifier: Int) {
        if favorites.contains(identifier) {
            if let index = favorites.firstIndex(of: identifier) {
                favorites.remove(at: index)
            }
        } else {
            favorites.append(identifier)
        }
    }
}
