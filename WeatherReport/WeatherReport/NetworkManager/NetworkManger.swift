//
//  NetworkManger.swift
//  WeatherReport
//
//  Created by Kittu Lalli on 06/07/21.
//

import Foundation

struct NetworkManger: NetworkManagerProtocol {
    
    static var shared: NetworkManagerProtocol = NetworkManger()
    
    func request(urlRequest: String, type: RequestType, handler: @escaping ((Result<Data, Error>) -> ())) {
        
        guard let url = URL(string: urlRequest) else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = type.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else {
                handler(.failure(error ?? NSError(domain: "Data Not found", code: 300, userInfo: nil)))
                return
            }
            handler(.success(data))
        }.resume()
    }
}
