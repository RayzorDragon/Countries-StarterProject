//
//  CountryMapViewModelTests.swift
//  CountriesAPITests
//
//  Created by Raymond Gatz on 8/22/24.
//

import Foundation
import MapKit
import XCTest
@testable import CountriesAPI
import _MapKit_SwiftUI

final class CountryMapViewModelTests: XCTestCase {
    
    var locationService: LocationService?
    var viewModel: CountryDetailMapViewModel?
    
    override func setUpWithError() throws {
        locationService = LocationService()
        viewModel = CountryDetailMapViewModel(country: mock_countryDetailModel_4, locationService: locationService!)
    }
    
    override func tearDownWithError() throws {
        locationService = nil
        viewModel = nil
    }
    
    
    func testLocationServiceAuthorization() throws {
        let expectation00 = expectation(description: "Authorization Not Determined Expectation")
        viewModel?.locationService.authorization = .notDetermined
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation00.fulfill()
        }
        wait(for: [expectation00], timeout: 2)
        XCTAssertFalse(viewModel!.permissionDetermined)
        XCTAssertFalse(viewModel!.permissionGranted)
        
        let expectation01 = expectation(description: "Authorization restricted Expectation")
        viewModel?.locationService.authorization = .restricted
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation01.fulfill()
        }
        wait(for: [expectation01], timeout: 2)
        XCTAssertTrue(viewModel!.permissionDetermined)
        XCTAssertFalse(viewModel!.permissionGranted)
        
        let expectation02 = expectation(description: "Authorization denied Expectation")
        viewModel?.locationService.authorization = .denied
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation02.fulfill()
        }
        wait(for: [expectation02], timeout: 2)
        XCTAssertTrue(viewModel!.permissionDetermined)
        XCTAssertFalse(viewModel!.permissionGranted)
        
        let expectation03 = expectation(description: "Authorization Authorized Always Expectation")
        viewModel?.locationService.authorization = .authorizedAlways
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation03.fulfill()
        }
        wait(for: [expectation03], timeout: 2)
        XCTAssertTrue(viewModel!.permissionDetermined)
        XCTAssertTrue(viewModel!.permissionGranted)
        
        let expectation04 = expectation(description: "Authorization Authorized White In Use Expectation")
        viewModel?.locationService.authorization = .authorizedWhenInUse
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation04.fulfill()
        }
        wait(for: [expectation04], timeout: 2)
        XCTAssertTrue(viewModel!.permissionDetermined)
        XCTAssertTrue(viewModel!.permissionGranted)
        
    }
    
    func testLocationServiceLastKnownLocation() throws {
        let expectation00Value = MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
                span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)))
        let returned00Value = viewModel?.localPosition
        
        XCTAssertEqual(expectation00Value, returned00Value)
        
        
        let expectation01 = expectation(description: "Loaded Location Expectation")
        let expectation01Input = CLLocationCoordinate2D(latitude: 47.12, longitude: -124.1)
        let expectation01Value = MapCameraPosition.region(
            MKCoordinateRegion(
                center: expectation01Input,
                span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)))
        viewModel?.locationService.lastKnownLocation = expectation01Input
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation01.fulfill()
        }
        wait(for: [expectation01], timeout: 2)
        let returned01Value = viewModel?.localPosition
        
        XCTAssertEqual(expectation01Value, returned01Value)
        
    }
    
    func testCountryPosition() throws {
        
        let expectationValue = MapCameraPosition.region(
            MKCoordinateRegion(
                center: (viewModel?.countryDetails.countryLatLong())!,
                span: MKCoordinateSpan(
                    latitudeDelta: Double(sqrtf((viewModel?.countryDetails.area)!))/111.0,
                    longitudeDelta: Double(sqrtf((viewModel?.countryDetails.area)!))/111.0
                )))
        
        let returnedValue = viewModel?.countryPosition
        
        XCTAssertEqual(expectationValue, returnedValue)
        
    }
    
    func testCapitalPosition() throws {
        
        let expectationValue = MapCameraPosition.region(
            MKCoordinateRegion(
                center: (viewModel?.countryDetails.capitalLatLong())!,
                span: MKCoordinateSpan(
                    latitudeDelta: 1.0,
                    longitudeDelta: 1.0
                )))
        
        let returnedValue = viewModel?.capitalPosition
        
        XCTAssertEqual(expectationValue, returnedValue)
        
    }
    
    func testStartLocationManager() throws {
        
    }
}
