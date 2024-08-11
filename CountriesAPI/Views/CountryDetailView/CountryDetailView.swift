//
//  CountryDetailView.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/11/24.
//

import SwiftUI

struct CountryDetailView <Model>: View where Model:CountryDetailViewModelInterface {
    
    @StateObject private var viewModel: Model
    init (viewModel: Model) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
        }
        .padding()
        .onAppear {
            viewModel.fetchCountryDetails()
        }
        .navigationTitle(Text(viewModel.countryDetails?.commonName() ?? "Country Name"))
    }
}

#Preview {
    CountryDetailView(viewModel: MockCountryDetailViewModel(country: mock_countriesListModel_1, countriesFetcher: CountryAPI()))
}
