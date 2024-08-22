//
//  MockCountryDetailMapViewModel.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/21/24.
//

import Foundation
import CoreLocation
import _MapKit_SwiftUI

class MockCountryDetailMapViewModel: CountryDetailMapViewModelInterface {
    
    
    @Published var countryDetails: CountryDetailModel
    @Published var locationManager: LocationManager
    @Published var permissionDetermined: Bool
    @Published var permissionGranted: Bool
    @Published var localPosition: MapCameraPosition
    @Published var countryPosition: MapCameraPosition
    @Published var capitalPosition: MapCameraPosition
    
    required init(country: CountryDetailModel, locationManager: LocationManager) {
        self.countryDetails = country
        self.locationManager = locationManager
        self.permissionDetermined = true
        self.permissionGranted = true
        self.localPosition = MapCameraPosition.region(
            MKCoordinateRegion(
                center: locationManager.lastKnownLocation ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
                span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
            )
        )
        self.countryPosition = MapCameraPosition.region(
            MKCoordinateRegion(
                center: country.countryLatLong() ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
                span: MKCoordinateSpan(latitudeDelta: Double(sqrtf(country.area ?? 1.0))/111.0, longitudeDelta: Double(sqrtf(country.area ?? 1.0))/111.0) // Without a proper Lat/Long border we're just going to need to guestimate how big of a map to show since some countries are significantly larger than others, thus we take the square root of the country, and divide it by 111 km, to give us an approximation of how many degrees to show.
            )
        )
        self.capitalPosition = MapCameraPosition.region(
            MKCoordinateRegion(
                center: country.capitalLatLong() ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
        )
    }
    
    func startLocationManager() { }
    
    
}
