//
//  WeatherReportViewModelTestCases.swift
//  WeatherReportTests
//
//  Created by Kittu Lalli on 07/07/21.
//

import XCTest
@testable import WeatherReport

class WeatherReportViewModelTestCases: XCTestCase {
    
    let viewModel = WeatherReportViewModel<MockNetworkManager>()
    
    override func setUpWithError() throws {
        viewModel.onViewModelUpdated = {
            XCTAssertTrue(self.viewModel.weatherViewModel?.count != 0)
        }
    }
    
    func testFetchWeatherDetails() {
        viewModel.fetchWeatherDetails { (error) in
            XCTAssertNil(error)
            XCTAssertTrue(self.viewModel.weatherViewModel?.count != 0)
        }
    }
    
    func testFailureFetchWeatherDetails() {
        var networkManager = (viewModel.networkManager as? MockNetworkManager)
        networkManager?.setFailure(true)
        viewModel.fetchWeatherDetails { (error) in
            XCTAssertNotNil(error)
            XCTAssertTrue(self.viewModel.weatherViewModel?.count == 0)
        }
    }
    
    func testFetchForecastDetails() {
        viewModel.fetchForecastDetails { (error) in
            XCTAssertNil(error)
            XCTAssertTrue(self.viewModel.weatherViewModel?.count != 0)
        }
    }
    
    func testFailureFetchForecastDetails() {
        var networkManager = (viewModel.networkManager as? MockNetworkManager)
        networkManager?.setFailure(true)
        viewModel.fetchForecastDetails { (error) in
            XCTAssertNotNil(error)
            XCTAssertTrue(self.viewModel.weatherViewModel?.count == 0)
        }
    }
    
    func testFetchReportsWeather() {
        viewModel.reportType = .weather
        viewModel.onViewModelUpdated = {
            XCTAssertTrue(self.viewModel.weatherViewModel?.count != 0)
        }
        viewModel.fetchReports()
    }
    
    func testFetchReportsForecast() {
        viewModel.reportType = .forecast
        viewModel.onViewModelUpdated = {
            XCTAssertTrue(self.viewModel.weatherViewModel?.count != 0)
        }
        viewModel.fetchReports()
    }
}
