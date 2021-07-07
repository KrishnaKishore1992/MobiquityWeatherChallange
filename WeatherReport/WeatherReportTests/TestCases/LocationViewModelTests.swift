//
//  LocationViewModelTests.swift
//  WeatherReportTests
//
//  Created by Kittu Lalli on 07/07/21.
//

import XCTest
@testable import WeatherReport
import CoreLocation

class LocationViewModelTests: XCTestCase {

    let viewmodel: LocationViewModel = LocationViewModel()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testGetLocationDetails() {
        viewmodel.getLocationDetails(for: CLLocationCoordinate2D(latitude: 78.4846, longitude: 17.5221)) { (result) in
            XCTAssertNotNil(result)
        }
    }
}
