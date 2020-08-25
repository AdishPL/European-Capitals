//
//  MasterListViewModelTests.swift
//  EuropeanCapitalsTests
//
//  Created by Adrian Kaczmarek on 25/08/2020.
//

import XCTest
@testable import EuropeanCapitals

class MasterListViewModelTests: XCTestCase {
    var sut: MasterListViewModel!
    var mockedAPIClient: MockedAPIClient<Capitals>!
    var mockedFavoritesManager: MockedFavoritesManager!
    
    override func setUp() {
        super.setUp()

        mockedAPIClient = MockedAPIClient()
        mockedFavoritesManager = MockedFavoritesManager()
        sut = MasterListViewModel(apiClient: mockedAPIClient, favoritesManager: mockedFavoritesManager)
    }
    
    override func tearDown() {
        mockedAPIClient = nil
        sut = nil

        super.tearDown()
    }
    
    func testToggleFavorite() {
        /// Given
        sut.items = [
            Capital(identifier: 0, name: "Warsaw", country: "Poland", photoKey: "noKey", isFavorite: false),
            Capital(identifier: 1, name: "Vienna", country: "Austria", photoKey: "noKey", isFavorite: false),
            Capital(identifier: 2, name: "Madrid", country: "Spain", photoKey: "noKey", isFavorite: true),
        ]
        mockedFavoritesManager.favorites = [2]
        
        /// When
        sut.toggleFavorite(atIndex: 1)
        sut.toggleFavorite(atIndex: 2)

        /// Then
        XCTAssertEqual(1, mockedFavoritesManager.favorites.count)
        XCTAssertFalse(sut.items[0].isFavorite)
        XCTAssertTrue(sut.items[1].isFavorite)
        XCTAssertFalse(sut.items[2].isFavorite)
    }
    
    func testLoadCapitalsSuccess() {
        /// Given
        mockedAPIClient.data = [
            Capital(identifier: 0, name: "Warsaw", country: "Poland", photoKey: "noKey"),
            Capital(identifier: 1, name: "Vienna", country: "Austria", photoKey: "noKey"),
        ]

        /// When
        let expectation = XCTestExpectation(description: "load capitals")
        sut.loadCapitals {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        
        /// Then
        XCTAssertEqual(2, sut.items.count)
        XCTAssertEqual(0, sut.items[0].identifier)
        XCTAssertEqual(1, sut.items[1].identifier)
    }

    func testLoadCapitalsFailure() {
        /// Given
        mockedAPIClient.forcedError = .noDataError

        /// When
        let expectation = XCTestExpectation(description: "api error")
        sut.loadCapitals {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        
        /// Then
        XCTAssertTrue(sut.items.isEmpty)
        XCTAssertEqual(sut.error, .noDataError)
    }
    
    func testCapitalAtIndex() {
        /// Given
        sut.items = [
            Capital(identifier: 0, name: "Warsaw", country: "Poland", photoKey: "noKey"),
            Capital(identifier: 1, name: "Vienna", country: "Austria", photoKey: "noKey"),
        ]

        /// When
        let capital = sut.item(atIndex: 1)
        
        /// Then
        XCTAssertNotNil(capital)
        XCTAssertEqual(1, capital?.identifier)
        XCTAssertEqual("Vienna", capital?.name)
        XCTAssertEqual("Austria", capital?.country)
    }
    
    func testCapitalAtIndexNil() {
        /// Given
        sut.items = [
            Capital(identifier: 0, name: "Warsaw", country: "Poland", photoKey: "noKey"),
            Capital(identifier: 1, name: "Vienna", country: "Austria", photoKey: "noKey"),
        ]

        /// When
        let capital = sut.item(atIndex: 2)
        
        /// Then
        XCTAssertNil(capital)
    }

    func testCellConfigure() {
        /// Given
        let cell = MockedCapitalTableViewCell()
        sut.items = [
            Capital(identifier: 0, name: "Warsaw", country: "Poland", photoKey: "noKey"),
            Capital(identifier: 1, name: "Vienna", country: "Austria", photoKey: "noKey"),
        ]
        
        /// When
        let expectation = XCTestExpectation(description: "Configures Cell with Capital")

        var configuredCapital: Capital? = nil
        cell.onConfigureCallback = { capital in
            configuredCapital = capital
            expectation.fulfill()
        }
        
        sut.configure(cell, atIndex: 1)
        
        /// Then
        wait(for: [expectation], timeout: 0.1)
        XCTAssertEqual(configuredCapital?.country, sut.items.last?.country)
    }
}
