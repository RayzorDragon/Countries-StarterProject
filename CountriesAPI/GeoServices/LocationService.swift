//
//  LocationService.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/21/24.
//

import Foundation
import CoreLocation

protocol LocationServiceInterface {
    
    var lastKnownLocation: CLLocationCoordinate2D? { get set }
    var authorization: CLAuthorizationStatus? { get set }
    func checkForLocationAuthorization()
}

class LocationService: NSObject, ObservableObject {
    
    @Published var lastKnownLocation: CLLocationCoordinate2D?
    @Published var authorization: CLAuthorizationStatus?
    private var manager = CLLocationManager()
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {//Trigged every time authorization status changes
        authorization = manager.authorizationStatus
        checkForLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
    
}

extension LocationService: LocationServiceInterface {
    
    func checkForLocationAuthorization() {
        manager.delegate = self
        manager.startUpdatingLocation()
        
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            print("Location restricted")
        case .denied:
            print("Location denied")
        case .authorizedAlways, .authorizedWhenInUse:
            print("Location Authorized")
            lastKnownLocation = manager.location?.coordinate
        @unknown default:
            print("Location service disabled")
        }
    }
    
}
