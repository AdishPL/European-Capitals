//
//  APIClientProtocol.swift
//  EuropeanCapitals
//
//  Created by Adrian Kaczmarek on 15/08/2020.
//

import Foundation

protocol APIClientProtocol {
    func request<T:Decodable>(target: APIResourceProtocol, type: T.Type, completion: @escaping (APIResult<T>) -> Void)
}
