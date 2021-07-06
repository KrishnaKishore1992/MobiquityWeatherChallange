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
    associatedtype NetworkManagerType
    static var shared: NetworkManagerType { get }
    func request(urlRequest: String, type: RequestType, handler: @escaping((Result<Data, Error>) -> ()))
}
