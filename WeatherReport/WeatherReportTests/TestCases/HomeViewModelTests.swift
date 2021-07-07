//
//  HomeViewModelTests.swift
//  WeatherReportTests
//
//  Created by Kittu Lalli on 06/07/21.
//

import XCTest
@testable import WeatherReport
import CoreLocation

class MockCLPlacemark: CLPlacemark {}

class HomeViewModelTests: XCTestCase {

    let viewModel: HomeViewModel = HomeViewModel()
    var locations: [BookMarkedModel] = []
    
    override func setUpWithError() throws {
        prepareMockBookMarkedModels()
    }
    
    private func prepareMockBookMarkedModels() {
        
        var bookmarkedLocation1 = BookMarkedModel()
        bookmarkedLocation1.name = "Hyderabad"
        bookmarkedLocation1.latitude = 53.04584
        bookmarkedLocation1.longitude = 23.89
        bookmarkedLocation1.countryCode = "IN"
        bookmarkedLocation1.administrativeArea = "administrativeArea1"
        
        var bookmarkedLocation2 = BookMarkedModel()
        bookmarkedLocation2.name = "Vizag"
        bookmarkedLocation2.latitude = 22.04584
        bookmarkedLocation2.longitude = 93.89
        bookmarkedLocation2.countryCode = "IN"
        bookmarkedLocation2.administrativeArea = "administrativeArea2"
        
        locations.append(bookmarkedLocation1)
        locations.append(bookmarkedLocation2)
    }
    
    func testAddNewBookmark() {
        viewModel.addNew(bookMark: locations[0])
        XCTAssertEqual(viewModel.bookMarkedLocations.count, 1)
        viewModel.addNew(bookMark: locations[1])
        XCTAssertEqual(viewModel.bookMarkedLocations.count, 2)
    }
    
    func testDeleteBookMark() {
        viewModel.addNew(bookMark: locations[0])
        viewModel.addNew(bookMark: locations[1])
        XCTAssertEqual(viewModel.bookMarkedLocations.count, 2)
        viewModel.delete(at: IndexPath(row: 0, section: 0))
        XCTAssertEqual(viewModel.bookMarkedLocations.count, 1)
    }
    
    func testFilter() {
        viewModel.addNew(bookMark: locations[0])
        viewModel.addNew(bookMark: locations[1])
        XCTAssertEqual(viewModel.bookMarkedLocations.count, 2)
        viewModel.mode = .search
        XCTAssertNotEqual(viewModel.bookMarkedLocations.count, 2)
        viewModel.filter("VIZAG")
        XCTAssertEqual(viewModel.bookMarkedLocations.count, 1)
        viewModel.filter("vizag")
        XCTAssertEqual(viewModel.bookMarkedLocations.count, 1)
        viewModel.filter("a")
        XCTAssertEqual(viewModel.bookMarkedLocations.count, 2)
        viewModel.mode = .default
        XCTAssertEqual(viewModel.bookMarkedLocations.count, 2)
    }
}
