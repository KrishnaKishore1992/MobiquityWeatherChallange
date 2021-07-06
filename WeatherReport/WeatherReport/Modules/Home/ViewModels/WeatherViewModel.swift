//
//  WeatherViewModel.swift
//  WeatherReport
//
//  Created by Kittu Lalli on 06/07/21.
//

import Foundation

struct WeatherViewModel {
    
    let date: String
    
    struct Report {
        let title: String
        let value: String
        let image: String
    }
    
    var reports: [Report] = []
    
    init(model: WeatherReportModel) {
        
        reports.append(Report(title: "Temperature", value: "\(model.main.temp.rounded())°\(Units.type.tempUnits)", image: "sun.max.fill"))
        reports.append(Report(title: "Weather Status", value: model.weather.first?.weatherDescription ?? "--", image: "cloud.fill"))
        reports.append(Report(title: "Chance of Rain", value: "\(model.clouds.all)%", image: "cloud.rain"))
        reports.append(Report(title: "Wind Speed", value: "\(model.wind.speed)\(Units.type.windSpeed)", image: "wind"))
        reports.append(Report(title: "Humidity", value: "\(model.main.humidity)%", image: "cloud.hail.fill"))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMM/yyyy hh:mm a"
        date = "Report Date: " + dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(model.dt)))
    }
}
