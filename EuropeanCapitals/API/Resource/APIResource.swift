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
    
    case getDetails
    
    case getMoreInfo
    
    /// API baseURL.
    var baseURL: String {
        switch self {
        case .getCapitals,
             .getDetails,
             .getMoreInfo:
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
            return "93da2250-93f6-409a-9d62-d227afd6b254"
        case .getDetails:
            /// Path generated by mocky.io service that returns details about some random city
            /// A delay was set to better simulate API response times
            return "26a2a839-998a-4fde-8266-76a4635f869d?mocky-delay=200ms"
        case .getMoreInfo:
            /// Path generated by mocky.io service that returns some random city description
            /// A delay was set to better simulate API response times
            return "7271983b-f48b-4bc6-b26b-eef0d70b7017?mocky-delay=300ms"
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
        case .getCapitals,
             .getDetails,
             .getMoreInfo:
            return .json
        case .getImage:
            return .image
        }
    }
}
