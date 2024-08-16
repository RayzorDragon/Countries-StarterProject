//
//  BookmarkedCountriesListView.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/15/24.
//

import SwiftUI

struct BookmarkedCountriesListView <Model>: View where Model:BookmarkedCountriesListViewModelInterface {
    
    @StateObject private var viewModel: Model
    
    init (viewModel: Model) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible(minimum: 100.0, maximum: UIScreen.main.bounds.size.width))]) {
                ForEach(viewModel.bookmarkedCountrylist) { country in
                    
                    CountryCellView(viewModel: CountryCellViewModel(country: country, countriesFetcher: CountriesAPIManager(), bookmarkManager: viewModel.bookmarkManager, showBookmark: false))
                            .padding(.bottom, 20.0)
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchBookmarkedCountryList()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    BookmarkedCountriesListView(viewModel: MockBookmarkedCountriesListViewModel(countriesFetcher: CountriesAPIManager(), bookmarkManager: BookmarkManager()))
}
