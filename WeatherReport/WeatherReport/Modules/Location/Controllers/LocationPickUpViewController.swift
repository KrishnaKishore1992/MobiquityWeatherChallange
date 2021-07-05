//
//  LocationPickUpViewController.swift
//  WeatherReport
//
//  Created by Kittu Lalli on 05/07/21.
//

import UIKit
import MapKit

class LocationPickUpViewController: BaseViewController {

    @IBOutlet private weak var mapView: MKMapView!
    
    let viewModel: LocationViewModel = LocationViewModel()
        
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        
        viewModel.getLocationDetails(for: mapView.region.center) { [self] in
            guard let bookMarkLocation = $0 else {
                self.showAlertwithTitle(message: "Unable to determine the location")
                return
            }
            self.viewModel.onLocationPicked?(bookMarkLocation)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
