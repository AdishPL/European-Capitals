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
            return "14c01069-9dcf-458d-b912-f7c6f020a01l"
        case .getDetails:
            /// Path generated by mocky.io service that returns details about some random city
            /// A delay was set to better simulate API response times
            return "4a6b40f1-e237-4df2-945f-d88f9e1d5bf1?mocky-delay=200ms"
        case .getMoreInfo:
            /// Path generated by mocky.io service that returns some random city description
            /// A delay was set to better simulate API response times
            return "16bca3dc-fe43-4603-abe7-0b3dc10444fa?mocky-delay=300ms"
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
