//
//  APIResult.swift
//  EuropeanCapitals
//
//  Created by Adrian Kaczmarek on 15/08/2020.
//

import Foundation

enum APIResult<T> {
    case success(T)
    case failure(APIError)
}
