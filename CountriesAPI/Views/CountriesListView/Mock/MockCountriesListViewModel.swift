//
//  MockCountriesListViewModel.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/10/24.
//

import Foundation

class MockCountriesListViewModel: CountriesListViewModelInterface {
    @Published var countryList: [CountryListModel]
    @Published var filteredCountryList: [CountryListModel]
    @Published var flagList: [String : Data?]
    @Published var searchableText: String
    private let countriesFetcher: CountriesFetchable
    required init(countriesFetcher: CountriesFetchable) {
        self.countriesFetcher = countriesFetcher
        self.countryList = [
            mock_countriesListModel_1
        ]
        self.filteredCountryList = []
        self.flagList = [mock_countriesListModel_1.flagURL(): Data()]
        self.searchableText = ""
    }
    func fetchCountryList() {}
    func downloadFlag(_ url: String) {}
}
