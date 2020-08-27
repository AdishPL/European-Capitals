//
//  FavoritesManager.swift
//  EuropeanCapitals
//
//  Created by Adrian Kaczmarek on 18/08/2020.
//

import Foundation

class FavoritesManager: FavoritesManagerProtocol {
    let defaults: UserDefaults = UserDefaults.standard
    let favoritesKey = "EuropeanCapitals.favorites"

    var favorites: [Int] {
        if let identifiers = defaults.array(forKey: favoritesKey) as? [Int] {
            return identifiers
        }
        return []
    }

    func toggleFavorite(_ identifier: Int) {
        var identifiers = favorites
        if identifiers.contains(identifier) {
            if let index = identifiers.firstIndex(of: identifier) {
                identifiers.remove(at: index)
            }
        } else {
            identifiers.append(identifier)
        }
        
        defaults.set(identifiers, forKey: favoritesKey)
    }
}
