//
//  APIResourceProtocol.swift
//  EuropeanCapitals
//
//  Created by Adrian Kaczmarek on 15/08/2020.
//

import Foundation

/// The protocol used to define the specifications necessary for a APIResource.
protocol APIResourceProtocol {
    /// API baseURL.
    var baseURL: String { get }

    /// The path that will be appended to API's base URL.
    var path: String { get }

    /// The HTTP method.
    var method: HTTPMethod { get }

    /// The expected responseType.
    var responseType: ResponseType { get }
}
