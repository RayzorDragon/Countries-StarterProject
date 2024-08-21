//
//  MockCountryDetailTabViewModel.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/19/24.
//

import Foundation

class MockCountryDetailTabViewModel: CountryDetailTabViewModelInterface {
    var detailsViewModel: CountryDetailViewModel
    
    var activeTab: Int
    
    @Published var countryDetails: CountryDetailModel
    @Published var bookmarkManager: any BookmarkManagerInterface
    required init(activeTab: Int = 0, country: CountryDetailModel, bookmarkManager: any BookmarkManagerInterface) {
        self.activeTab = activeTab
        self.countryDetails = country
        self.bookmarkManager = bookmarkManager
        self.detailsViewModel = CountryDetailViewModel(country: country, countriesFetcher: CountriesAPIManager(), bookmarkManager: bookmarkManager)
    }
    
    func mapButtonTapped() { }
}
