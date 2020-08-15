//
//  APIError.swift
//  EuropeanCapitals
//
//  Created by Adrian Kaczmarek on 15/08/2020.
//

import Foundation

enum APIError: Error {
    case noDataError
    case networkError
    case decodingError
}
