//
//  ContentView.swift
//  ContriesAPI
//
//  Created by Choudhary, Alok on 9/6/23.
//

import SwiftUI

struct CountriesListView <Model>: View where Model:CountriesListViewModelInterface {
    
    @StateObject private var viewModel: Model
    init (viewModel: Model) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible(minimum: 100.0, maximum: UIScreen.main.bounds.size.width))]) {
                ForEach(viewModel.filteredCountryList) { country in
                    CountryCellView(viewModel: viewModel, country: country)
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchCountryList()
        }
        .searchable(text: $viewModel.searchableText)
    }
}

struct CountriesListView_Previews: PreviewProvider {
    static var previews: some View {
        CountriesListView(viewModel: MockCountriesListViewModel(countriesFetcher: CountryAPI()))
    }
}
