//
//  MockNetworkManager.swift
//  WeatherReportTests
//
//  Created by Kittu Lalli on 06/07/21.
//

@testable import WeatherReport
import Foundation

struct MockNetworkManager: NetworkManagerProtocol {
    
    static let shared: MockNetworkManager = MockNetworkManager()
    
    func request(urlRequest: String, type: RequestType, handler: @escaping ((Result<Data, Error>) -> ())) {
        
    }
}

