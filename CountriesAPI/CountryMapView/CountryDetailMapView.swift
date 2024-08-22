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
    
    init (viewModel: Model) {
        _viewModel = StateObject(wrappedValue: viewModel)
        
        
    }
    var body: some View {
        ScrollView {
            if viewModel.permissionDetermined == false {
                EmptyView()
            } else {
                if viewModel.permissionGranted {
                    localMapScreen()
                }
                countryMapScreen()
                capitalMapScreen()
            }
        }
        .onAppear {
            viewModel.startLocationManager()
        }
    }
    
    @ViewBuilder func localMapScreen() -> some View {
        VStack(alignment: .leading, spacing: 0.0) {
            Text("Your Current Location")
                .font(countryDetailGenericTitleFont())
                .foregroundStyle(grayColorCountryDetailsTitle())
            Map(position: $viewModel.localPosition, interactionModes: [])
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 2.0/3.0)
        }
    }
    
    @ViewBuilder func countryMapScreen() -> some View {
        VStack(alignment: .leading, spacing: 0.0) {
            genericTextView(string1: "Country - ", string2: viewModel.countryDetails.commonName())
            Map(position: $viewModel.countryPosition, interactionModes: [])
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 2.0/3.0)
        }
    }
    
    @ViewBuilder func capitalMapScreen() -> some View {
        VStack(alignment: .leading, spacing: 0.0) {
            genericTextView(string1: "Capital - ", string2: viewModel.countryDetails.firstCapital())
            Map(position: $viewModel.capitalPosition, interactionModes: [])
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 2.0/3.0)
        }
    }
    
    @ViewBuilder func genericTextView(string1: String, string2: String) -> some View {
            Text(string1)
                .font(countryDetailGenericTitleFont())
                .foregroundStyle(grayColorCountryDetailsTitle())
            + Text(string2)
                .font(countryDetailGenericInfoFont())
                .foregroundStyle(grayColorCountryDetailsInfo())
    }
}

#Preview {
    CountryDetailMapView(viewModel: MockCountryDetailMapViewModel(country: mock_countryDetailModel_1, locationManager: LocationManager()))
}
