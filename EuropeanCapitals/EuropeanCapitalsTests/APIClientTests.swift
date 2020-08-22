//
//  APIClientTests.swift
//  EuropeanCapitalsTests
//
//  Created by Adrian Kaczmarek on 22/08/2020.
//

import XCTest
@testable import EuropeanCapitals

class APIClientTests: XCTestCase {
    let capitalsJSON = """
        [
            {
                "id": 0,
                "country": "Austria",
                "city": "Vienna",
                "photo": "640x360?Vienna"
            },
            {
                "id": 1,
                "country": "Belgium",
                "city": "Brussels",
                "photo": "640x360?Brussels"
            }
        ]
        """
    
    let failingJSON = """
        {]
        """
    
    let apiClient = APIClient()
    
    func testSerializedJSONSucess() {
        /// Given
        guard let jsonData: Data = capitalsJSON.data(using: .utf8) else {
            fatalError("Cannot create data from string")
        }
        let error: Error? = nil

        /// When
        let result = apiClient.serializedJSON(with: jsonData, error: error) as APIResult<Capitals>

        /// Then
        switch result {
        case .success(let cities):
            XCTAssertEqual(2, cities.count)
        case .failure(_):
            XCTFail()
        }
    }
    
    func testSerializedJSONFailureDecodingError() {
        /// Given
        guard let jsonData: Data = failingJSON.data(using: .utf8) else {
            fatalError("Cannot create data from string")
        }
        let error: Error? = nil

        /// When
        let result = apiClient.serializedJSON(with: jsonData, error: error) as APIResult<Capitals>

        /// Then
        switch result {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssertEqual(error, .decodingError)
        }
    }
    
    func testSerializedJSONFailureNoDataError() {
        /// Given
        let jsonData: Data? = nil
        let error: Error? = nil
        
        /// When
        let result = apiClient.serializedJSON(with: jsonData, error: error) as APIResult<Capitals>

        /// Then
        switch result {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssertEqual(error, .noDataError)
        }
    }

    func testSerializedJSONFailureNetworkError() {
        /// Given
        let jsonData: Data? = nil
        let error: Error? = MockedError()

        /// When
        let result = apiClient.serializedJSON(with: jsonData, error: error) as APIResult<Capitals>

        /// Then
        switch result {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssertEqual(error, .networkError)
        }
    }

    func testSerializedImageSuccess() {
        /// Given
        let imageData: Data? = UIImage(named: "iconHeartSolid")?.pngData()
        let error: Error? = nil

        /// When
        let result = apiClient.serializedImage(with: imageData, error: error) as APIResult<Image>

        /// Then
        switch result {
        case .success(let image):
            XCTAssertEqual(image.imageData.count, imageData?.count)
        case .failure(_):
            XCTFail()
        }
    }
    
    func testSerializedImageFailureNoDataError() {
        /// Given
        let imageData: Data? = nil
        let error: Error? = nil

        /// When
        let result = apiClient.serializedImage(with: imageData, error: error) as APIResult<Image>

        /// Then
        switch result {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssertEqual(error, .noDataError)
        }
    }

    func testSerializedImageFailureNetworkError() {
        /// Given
        let imageData: Data? = nil
        let error: Error? = MockedError()

        /// When
        let result = apiClient.serializedImage(with: imageData, error: error) as APIResult<Image>

        /// Then
        switch result {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssertEqual(error, .networkError)
        }
    }
}
