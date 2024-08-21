//
//  CountryDetailMapView.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/19/24.
//

import SwiftUI
import MapKit
import CoreLocation

struct CountryDetailMapView <Model>: View where Model: CountryDetailMapViewModelInterface {
    
    @StateObject private var viewModel: Model
    @State private var localPosition: MapCameraPosition
    @State private var countryPosition: MapCameraPosition
    @State private var capitalPosition: MapCameraPosition
    
    init (viewModel: Model) {
        _viewModel = StateObject(wrappedValue: viewModel)
        localPosition = MapCameraPosition.region(
            MKCoordinateRegion(
                center: viewModel.locationManager.lastKnownLocation ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
                span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
            )
        )
        countryPosition = MapCameraPosition.region(
            MKCoordinateRegion(
                center: viewModel.countryDetails.countryLatLong() ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
                span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
            )
        )
        capitalPosition = MapCameraPosition.region(
            MKCoordinateRegion(
                center: viewModel.countryDetails.capitalLatLong() ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
        )
        
        
    }
    var body: some View {
        ScrollView {
            if true {
                EmptyView()
            } else {
                if false {
                    localMapScreen()
                }
                countryMapScreen()
                capitalMapScreen()
            }
        }
        .background(Color.gray)
        .onAppear {
            viewModel.startLocationManager()
        }
    }
    
    @ViewBuilder func localMapScreen() -> some View {
        VStack {
            Text("Your Current Location")
            Map(position: $localPosition, interactionModes: [])
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 2.0/3.0)
        }
    }
    
    @ViewBuilder func countryMapScreen() -> some View {
        VStack {
            Text("Country - \(viewModel.countryDetails.commonName())")
            Map(position: $countryPosition, interactionModes: [])
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 2.0/3.0)
        }
    }
    
    @ViewBuilder func capitalMapScreen() -> some View {
        VStack {
            Text("Capital - \(viewModel.countryDetails.firstCapital())")
            Map(position: $capitalPosition, interactionModes: [])
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 2.0/3.0)
        }
    }
}

#Preview {
    CountryDetailMapView(viewModel: MockCountryDetailMapViewModel(country: mock_countryDetailModel_1, locationManager: LocationManager()))
}
