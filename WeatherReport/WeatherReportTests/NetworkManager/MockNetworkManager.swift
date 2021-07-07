//
//  MockNetworkManager.swift
//  WeatherReportTests
//
//  Created by Kittu Lalli on 06/07/21.
//

@testable import WeatherReport
import Foundation

struct MockNetworkManager: NetworkManagerProtocol {
    
    private var sendFailureReponse: Bool = false
    
    static var shared: NetworkManagerProtocol = MockNetworkManager()
    
    mutating func setFailure(_ response: Bool) {
        sendFailureReponse = response
    }
    
    func request(urlRequest: String, type: RequestType, handler: @escaping ((Result<Data, Error>) -> ())) {
        var mockJson: String = urlRequest.contains("weather") ? "weather" : "forecast"
        if sendFailureReponse {
            mockJson+="failure"
        }
        if let url = Bundle.main.url(forResource: mockJson, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                handler(.success(data))
            } catch {
                handler(.failure(error))
            }
        }
    }
}

