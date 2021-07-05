//
//  LocationViewModel.swift
//  WeatherReport
//
//  Created by Kittu Lalli on 05/07/21.
//

import Foundation
import CoreLocation

class LocationViewModel {
    
    private var geoCoder: CLGeocoder = CLGeocoder()
    
    var onLocationPicked: ((BookMarkedModel) -> Void)?
    
    func getLocationDetails(for location: CLLocationCoordinate2D, onCompletion: @escaping ((BookMarkedModel?) -> Void)) {
        
        let selectedLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        
        geoCoder.reverseGeocodeLocation(selectedLocation) { placemarks, error in
            onCompletion(BookMarkedModel(placemark: placemarks?.first))
        }
    }
}
