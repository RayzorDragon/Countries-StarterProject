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
                    NavigationLink {
                        CountryDetailTabView(viewModel: CountryDetailTabViewModel(country: country, bookmarkManager: viewModel.bookmarkManager))
                            .toolbar(.hidden, for: .tabBar)
                    } label: {
                        CountryCellView(viewModel: CountryCellViewModel(country: country, countriesFetcher: CountriesAPIManager(), bookmarkManager: viewModel.bookmarkManager, showBookmark: true))
                            .padding(.bottom, 20.0)
                    }
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchCountryList()
        }
        .searchable(text: $viewModel.searchableText)
        .navigationTitle(Text("Counties"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CountriesListView_Previews: PreviewProvider {
    static var previews: some View {
        CountriesListView(viewModel: MockCountriesListViewModel(countriesFetcher: CountriesAPIManager(), bookmarkManager: BookmarkManager()))
    }
}
