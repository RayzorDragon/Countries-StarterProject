//
//  MockLocationService.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/22/24.
//

import Foundation
import CoreLocation

class MockLocationService: NSObject, LocationServiceInterface {
    
    @Published var lastKnownLocation: CLLocationCoordinate2D?
    @Published var authorization: CLAuthorizationStatus?
    
    private var managerStartedUpdatingLocation = false
    private var managerRequestedAuthorizationWhileInUse = false
    
    
    func checkForLocationAuthorization() {
        managerStartedUpdatingLocation = true
        
        switch authorization {
        case .notDetermined:
            print("Request authorization status")
            managerRequestedAuthorizationWhileInUse = true
        case .restricted:
            print("Location restricted")
        case .denied:
            print("Location denied")
        case .authorizedAlways, .authorizedWhenInUse:
            print("Location Authorized")
            locationManager(didUpdate: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0))
        case .none:
            print("Location status nil")
        @unknown default:
            print("Location service disabled")
        }
    }
    
    func locationManagerDidChangeAuthorization(status: CLAuthorizationStatus) {
        authorization = status
        checkForLocationAuthorization()
    }
    
    func locationManager(didUpdate locations: CLLocationCoordinate2D) {
        lastKnownLocation = locations
    }
}

extension MockLocationService: ObservableObject { }
