//
//  Collection+Extensions.swift
//  EuropeanCapitals
//
//  Created by Adrian Kaczmarek on 18/08/2020.
//

import Foundation

extension Collection {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
