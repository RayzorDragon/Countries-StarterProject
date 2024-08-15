//
//  MockCountriesListViewModel.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/10/24.
//

import Foundation

class MockCountriesListViewModel: CountriesListViewModelInterface {
    
    
    @Published var countryList: [CountryDetailModel]
    @Published var filteredCountryList: [CountryDetailModel]
    @Published var searchableText: String
    @Published var bookmarkManager: any BookmarkManagerInterface
    private let countriesFetcher: CountriesFetchable
    required init(countriesFetcher: any CountriesFetchable, bookmarkManager: any BookmarkManagerInterface) {
        self.bookmarkManager = bookmarkManager
        self.countriesFetcher = countriesFetcher
        self.countryList = [
            mock_countryDetailModel_1
        ]
        self.filteredCountryList = []
        self.searchableText = ""
    }
    func fetchCountryList() {}
    func downloadFlag(_ sourceModel: ImageSourceModel) {}
}
