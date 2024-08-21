//
//  CountryDetailTabView.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/19/24.
//

import SwiftUI

struct CountryDetailTabView <Model>: View where Model: CountryDetailTabViewModelInterface {
    
    @StateObject private var viewModel: Model
    init (viewModel: Model) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        TabView(selection: $viewModel.activeTab) {
            NavigationStack {
                CountryDetailView(
                    viewModel: CountryDetailViewModel(
                        country: viewModel.countryDetails,
                        countriesFetcher: CountriesAPIManager(),
                        bookmarkManager: viewModel.bookmarkManager,
                        countryTabViewModel: viewModel))
            }
            .tabItem {
                Text("Overview")
                Image(systemName: "star")
            }
            .tag(0)
            
            NavigationStack {
                CountryDetailMapView(viewModel: CountryDetailMapViewModel(country: viewModel.countryDetails, locationManager: LocationManager()))
            }
            .tabItem {
                Text("Map")
                Image(systemName: "map")
                    .environment(\.symbolVariants, .none)
            }
            .tag(1)
        }
    }
}

#Preview {
    CountryDetailTabView(viewModel: MockCountryDetailTabViewModel(country: mock_countryDetailModel_1, bookmarkManager: BookmarkManager()))
}
