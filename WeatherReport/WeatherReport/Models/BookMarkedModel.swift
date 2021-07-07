//
//  BookMarkedModel.swift
//  WeatherReport
//
//  Created by Kittu Lalli on 05/07/21.
//

import CoreLocation

struct BookMarkedModel {
    
    var name: String?
    var locality: String?
    var sublocality: String?
    var administrativeArea: String?
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    var countryCode: String?
    
    init() {
        
    }
    
    init?(placemark: CLPlacemark?) {
        
        guard let placemark = placemark else { return nil }
        
        name = placemark.name
        locality = placemark.locality
        sublocality = placemark.subLocality
        administrativeArea = placemark.administrativeArea
        latitude = placemark.location?.coordinate.latitude
        longitude = placemark.location?.coordinate.longitude
        countryCode = placemark.country
    }
}
