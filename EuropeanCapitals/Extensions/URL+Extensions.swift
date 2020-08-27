//
//  URL+Extensions.swift
//  EuropeanCapitals
//
//  Created by Adrian Kaczmarek on 18/08/2020.
//

import Foundation

extension URL {
    /// Initialize URL from `APIResourceProtocol`.
    init<T: APIResourceProtocol>(target: T) {
        if target.path.isEmpty {
            guard let url = URL(string: target.baseURL) else {
                fatalError("You didn't set baseURL properly")
            }
            self = url

        } else {
            guard let url = URL(string: target.baseURL + target.path) else {
                fatalError("You didn't set path properly")
            }
            self = url
        }
    }
}
