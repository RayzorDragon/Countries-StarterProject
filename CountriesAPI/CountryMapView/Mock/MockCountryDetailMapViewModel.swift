//
//  MockCountryDetailMapViewModel.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/21/24.
//

import Foundation

class MockCountryDetailMapViewModel: CountryDetailMapViewModelInterface {
    
    @Published var countryDetails: CountryDetailModel
    @Published var locationManager: LocationManager
    
    required init(country: CountryDetailModel, locationManager: LocationManager) {
        self.countryDetails = country
        self.locationManager = locationManager
    }
    
    func startLocationManager() { }
    
    
}
