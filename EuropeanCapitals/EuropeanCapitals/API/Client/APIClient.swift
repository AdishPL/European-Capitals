//
//  APIClient.swift
//  EuropeanCapitals
//
//  Created by Adrian Kaczmarek on 18/08/2020.
//

import Foundation

/// API Client class. Requests should be made through this class only.
class APIClient: APIClientProtocol {
    /// Designated request-making method.
    func request<T:Decodable>(target: APIResource,
                              type: T.Type,
                              completion: @escaping (APIResult<T>) -> Void) {
    
        let defaultSession = URLSession(configuration: .default)
        
        let dataTask = defaultSession.dataTask(
            with: URL(target: target)
        ) { data, response, error in
            var result: APIResult<T>
            
            switch target {
            case .getCapitals,
                 .getDetails,
                 .getMoreInfo:
                result = self.serializedJSON(with: data, error: error)
            case .getImage:
                result = self.serializedImage(with: data, error: error)
            }
            
            completion(result)
        }
        
        dataTask.resume()
    }
}

// MARK: - Private serialization methods

extension APIClient {
    /// Used to deserialize `JSON` from `Data` object passed in parameters
    func serializedJSON<T:Decodable>(with data: Data?, error: Error?) -> APIResult<T> {
        if error != nil { return .failure(.networkError) }
        guard let data = data else { return .failure(.noDataError) }
        
        do {
            let serializedValue = try JSONDecoder().decode(T.self, from: data)
            return .success(serializedValue)
        } catch {
            return .failure(.decodingError)
        }
    }

    /// Used to convert `Data` to `Image` object
    func serializedImage<T:Decodable>(with data: Data?, error: Error?) -> APIResult<T> {
        if error != nil { return .failure(.networkError) }
        guard let data = data else { return .failure(.noDataError) }
        guard let image = Image(imageData: data) as? T else { return .failure(.noDataError) }
        return .success(image)
    }
}

