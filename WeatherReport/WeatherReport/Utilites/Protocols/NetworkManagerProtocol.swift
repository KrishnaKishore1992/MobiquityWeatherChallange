//
//  NetworkManagerProtocol.swift
//  WeatherReport
//
//  Created by Kittu Lalli on 05/07/21.
//

import Foundation

enum RequestType: String {
    case get = "GET"
    case post = "POST"
}

protocol NetworkManagerProtocol {
    
    static func request(urlRequest: String, type: RequestType, handler: @escaping((Result<Data, Error>) -> ()))
}
