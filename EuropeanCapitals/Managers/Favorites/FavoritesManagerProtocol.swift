//
//  FavoritesManagerProtocol.swift
//  EuropeanCapitals
//
//  Created by Adrian Kaczmarek on 18/08/2020.
//

import Foundation

protocol FavoritesManagerProtocol {
    var favorites: [Int] { get }
    func toggleFavorite(_ identifier: Int)
}
