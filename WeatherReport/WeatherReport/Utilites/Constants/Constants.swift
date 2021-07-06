//
//  Constants.swift
//  WeatherReport
//
//  Created by Kittu Lalli on 06/07/21.
//

import Foundation

extension NSNotification.Name {
    static let unitsChanged: NSNotification.Name = NSNotification.Name("UnitsChanged")
    static let clearBookMarkedLocations: NSNotification.Name = NSNotification.Name("ClearBookMarkedLocations")
}

enum Units: String {
    
    case metrics, imperial
    
    static var type: Units = .imperial {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name.unitsChanged, object: nil)
        }
    }
    
    var tempUnits: String {
        switch self {
        case .imperial:
            return "F"
        case .metrics:
            return "K"
        }
    }
    
    var windSpeed: String {
        switch self {
        case .imperial:
            return "mph"
        case .metrics:
            return "m/s"
        }
    }
}

enum APIConstants {
    
    case getWeatherAPI
    case getForecastAPI
    
    var rawValue: String {
        switch self {
        case .getWeatherAPI:
            return "http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&appid=fae7190d7e6433ec3a45285ffcf55c86&units=%@"
        case .getForecastAPI:
            return "http://api.openweathermap.org/data/2.5/forecast?lat=%f&lon=%f&appid=fae7190d7e6433ec3a45285ffcf55c86&units=%@"
        }
    }
}
