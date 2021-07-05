//
//  BookMarkCellViewModel.swift
//  WeatherReport
//
//  Created by Kittu Lalli on 05/07/21.
//

import Foundation

struct BookMarkedViewModel {
    
    var name: String
    var description: String
    
    init(model: BookMarkedModel) {
        name = model.name ?? "NA"
        let administrativeArea = model.administrativeArea ?? "--"
        let countryCode = model.countryCode ?? "--"
        description = [administrativeArea, countryCode].joined(separator: ", ")
    }
}
