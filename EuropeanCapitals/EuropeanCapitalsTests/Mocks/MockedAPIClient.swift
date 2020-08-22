//
//  MockedAPIClient.swift
//  EuropeanCapitalsTests
//
//  Created by Adrian Kaczmarek on 22/08/2020.
//

import Foundation
@testable import EuropeanCapitals

class MockedAPIClient<T: Decodable>: APIClientProtocol {
    var forcedError: APIError?
    var data: T? = nil

    func request<T>(target: APIResource, type: T.Type, completion: @escaping (APIResult<T>) -> Void) {
        if let error = forcedError {
            completion(.failure(error))
        } else {
            completion(.success(data as! T))
        }
    }
}
