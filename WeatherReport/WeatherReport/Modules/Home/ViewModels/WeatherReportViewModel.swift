//
//  WeatherReportViewModel.swift
//  WeatherReport
//
//  Created by Kittu Lalli on 06/07/21.
//

import Foundation

class WeatherReportViewModel {
    
    enum ReportType {
        case weather, forecast
    }
    
    var reportType: ReportType = .weather {
        didSet {
            fetchReports()
        }
    }
    
    private var weatherReportDetails: [WeatherViewModel]?
    private var forecastReportDetails: [WeatherViewModel]?
    
    var bookMarkedModel: BookMarkedModel?
    var weatherViewModel: [WeatherViewModel]?
    var onViewModelUpdated: (() -> Void)?
    var networkManager: some NetworkManagerProtocol = NetworkManger.shared
    
    func startObserveOnUnitsChange() {
        
        NotificationCenter.default.addObserver(forName: .unitsChanged, object: nil, queue: nil) { [weak self] (_) in
            self?.weatherReportDetails = nil
            self?.forecastReportDetails = nil
            self?.fetchReports()
        }
    }
    
    func fetchReports() {
        switch reportType {
        case .forecast:
            guard forecastReportDetails != nil else {
                fetchForecastDetails()
                return
            }
            weatherViewModel = forecastReportDetails
        case .weather:
            weatherViewModel = weatherReportDetails
        }
        onViewModelUpdated?()
    }
        
    func fetchForecastDetails(_ completion: ((Error?) -> ())? = nil) {
        
        guard let latitude = bookMarkedModel?.latitude, let longitude = bookMarkedModel?.longitude else { return }
        
        let apiUrl = String(format: APIConstants.getForecastAPI.rawValue, latitude, longitude, Units.type.rawValue)
        
        networkManager.request(urlRequest: apiUrl, type: .get) { [weak self] (result) in
            switch result {
            case .success(let jsonData):
                do {
                    let weatherReportModel = try JSONDecoder().decode(WeatherForecastModel.self, from: jsonData)
                    self?.forecastReportDetails = weatherReportModel.list.map { WeatherViewModel(model: $0) }
                    self?.weatherViewModel = self?.forecastReportDetails
                    self?.onViewModelUpdated?()
                } catch let error {
                    print(error)
                    completion?(error)
                }
            case .failure(let error):
                completion?(error)
            }
        }
    }
    
    func fetchWeatherDetails(_ completion: @escaping(Error?) -> ()) {
        
        guard let latitude = bookMarkedModel?.latitude, let longitude = bookMarkedModel?.longitude else { return }
        
        let apiUrl = String(format: APIConstants.getWeatherAPI.rawValue, latitude, longitude, Units.type.rawValue)
        
        networkManager.request(urlRequest: apiUrl, type: .get) { [weak self] (result) in
            switch result {
            case .success(let jsonData):
                do {
                    let weatherReportModel = try JSONDecoder().decode(WeatherReportModel.self, from: jsonData)
                    self?.weatherReportDetails = [WeatherViewModel(model: weatherReportModel)]
                    self?.weatherViewModel = self?.weatherReportDetails
                    self?.onViewModelUpdated?()
                    completion(nil)
                } catch let error {
                    completion(error)
                }
            case .failure(let error):
                completion(error)
            }
        }
    }
}
