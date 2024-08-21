//
//  CountryDetailMapViewModel.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/21/24.
//

import Foundation
import Combine
import MapKit

protocol CountryDetailMapViewModelInterface: ObservableObject {
    var countryDetails: CountryDetailModel { get set }
    var locationManager: LocationManager { get set }
    
    init(country: CountryDetailModel, locationManager: LocationManager)
    
    func startLocationManager()
}

class CountryDetailMapViewModel {
    @Published var countryDetails: CountryDetailModel
    @Published var locationManager: LocationManager
    
    required init(country: CountryDetailModel, locationManager: LocationManager) {
        self.countryDetails = country
        self.locationManager = locationManager
    }
}

extension CountryDetailMapViewModel: CountryDetailMapViewModelInterface {
    
    func startLocationManager() {
        locationManager.checkForLocationAuthorization()
    }
}
