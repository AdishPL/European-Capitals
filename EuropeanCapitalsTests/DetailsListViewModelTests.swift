//
//  DetailsListViewModelTests.swift
//  EuropeanCapitalsTests
//
//  Created by Adrian Kaczmarek on 22/08/2020.
//

import XCTest
@testable import EuropeanCapitals

class DetailsListViewModelTests: XCTestCase {
    var sut: DetailsListViewModel!
    var mockedAPIClient: MockedAPIClient<CapitalDetails>!
    
    override func setUp() {
        super.setUp()

        let capital = Capital(identifier: 0, name: "Test", country: "Test", photoKey: "noKey")
        
        mockedAPIClient = MockedAPIClient()
        sut = DetailsListViewModel(for: capital, apiClient: mockedAPIClient)
    }
    
    override func tearDown() {
        mockedAPIClient = nil
        sut = nil

        super.tearDown()
    }
    
    func testLoadDetailsSuccess() {
        /// Given
        mockedAPIClient.data = CapitalDetails(population: "100", timeZone: "UTC", area: "500")

        /// When
        let expectation = XCTestExpectation(description: "load details")
        sut.loadDetails {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        
        /// Then
        XCTAssertNotNil(sut.details)
        XCTAssertEqual("100", sut.details?.population)
        XCTAssertEqual("UTC", sut.details?.timeZone)
        XCTAssertEqual("500", sut.details?.area)
    }
    
    func testLoadDetailsFailure() {
        /// Given
        mockedAPIClient.forcedError = .noDataError

        /// When
        let expectation = XCTestExpectation(description: "api error")
        sut.loadDetails {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        
        /// Then
        XCTAssertNil(sut.details)
        XCTAssertEqual(sut.error, .noDataError)
    }
}
