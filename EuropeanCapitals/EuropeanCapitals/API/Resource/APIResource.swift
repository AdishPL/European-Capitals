//
//  APIClient.swift
//  EuropeanCapitals
//
//  Created by Adrian Kaczmarek on 15/08/2020.
//

import Foundation

enum APIResource: APIResourceProtocol {
    case getCapitals
    case getImage(key: String)
    
    /// API baseURL.
    var baseURL: String {
        switch self {
        case .getCapitals:
            return MockyService.mockyBaseUrl
        case .getImage:
            return UnsplashService.unsplashBaseUrl
        }
    }
    
    /// The path that will be appended to API's base URL.
    var path: String {
        switch self {
        case .getCapitals:
            /// Path generated by mocky.io service that returns a custom built list of cities in JSON format
            /// Its possible to set a delay
            return "14c01069-9dcf-458d-b912-f7c6f020a01l"
        case .getImage(let key):
            /// Unsplash API path returning random photo
            return key
        }
    }
    
    /// The HTTP method.
    var method: HTTPMethod {
        return .GET
    }
    
    /// The expected responseType.
    var responseType: ResponseType {
        switch self {
        case .getCapitals:
            return .json
        case .getImage:
            return .image
        }
    }
}