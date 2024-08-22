//
//  CountryDetailMapViewModel.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/21/24.
//

import Foundation
import Combine
import MapKit
import _MapKit_SwiftUI

protocol CountryDetailMapViewModelInterface: ObservableObject {
    var countryDetails: CountryDetailModel { get set }
    var locationService: LocationService { get set }
    var permissionDetermined: Bool { get set }
    var permissionGranted: Bool { get set }
    var localPosition: MapCameraPosition { get set }
    var countryPosition: MapCameraPosition { get set }
    var capitalPosition: MapCameraPosition { get set }
    
    init(country: CountryDetailModel, locationService: LocationService)
    
    func startLocationManager()
}

class CountryDetailMapViewModel {
    @Published var countryDetails: CountryDetailModel
    @Published var locationService: LocationService
    @Published var permissionDetermined: Bool
    @Published var permissionGranted: Bool
    @Published var localPosition: MapCameraPosition
    @Published var countryPosition: MapCameraPosition
    @Published var capitalPosition: MapCameraPosition
    private var disposables = Set<AnyCancellable>()
    
    required init(country: CountryDetailModel, locationService: LocationService) {
        self.countryDetails = country
        self.locationService = locationService
        self.permissionGranted = false
        self.permissionDetermined = false
        self.localPosition = MapCameraPosition.region(
            MKCoordinateRegion(
                center: locationService.lastKnownLocation ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
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
                span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
            )
        )
        
        locationService.$authorization
            .compactMap { $0 }
            .sink  { (_) in
            } receiveValue: { [self] (authStatus) in
                switch authStatus {
                    
                case .notDetermined:
                    self.permissionDetermined = false
                    self.permissionGranted = false
                case .restricted, .denied:
                    self.permissionDetermined = true
                    self.permissionGranted = false
                case .authorizedAlways, .authorizedWhenInUse:
                    self.permissionDetermined = true
                    self.permissionGranted = true
                @unknown default:
                    self.permissionDetermined = false
                    self.permissionGranted = false
                }
            }.store(in: &disposables)
        
        locationService.$lastKnownLocation
            .compactMap { $0 }
            .sink { (_) in
            } receiveValue: { [self] (lastLocation) in
                self.localPosition = MapCameraPosition.region(
                    MKCoordinateRegion(
                        center: lastLocation,
                        span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                    )
                )
            }.store(in: &disposables)
    }
}

extension CountryDetailMapViewModel: CountryDetailMapViewModelInterface {
    
    func startLocationManager() {
        locationService.checkForLocationAuthorization()
    }
}
