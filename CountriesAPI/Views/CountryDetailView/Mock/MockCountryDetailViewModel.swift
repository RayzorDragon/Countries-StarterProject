//
//  MockCountryDetailViewModel.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/11/24.
//

import Foundation

class MockCountryDetailViewModel: CountryDetailViewModelInterface {
    
    @Published var countryDetails: CountryDetailModel
    @Published var bookmarkManager: any BookmarkManagerInterface
    @Published var bookmarked: Bool
    private let countriesFetcher: CountriesFetchable
    required init(country: CountryDetailModel, countriesFetcher: CountriesFetchable, bookmarkManager: any BookmarkManagerInterface) {
        self.countriesFetcher = countriesFetcher
        self.countryDetails = country
        self.bookmarkManager = bookmarkManager
        self.bookmarked = false
    }
    func downloadFlag(_ sourceModel: ImageSourceModel) {}
    func downloadCoatOfArms(_ sourceModel: ImageSourceModel) {}
    func saveButtonTapped() { }
    func mapButtonTapped() { }
    
    
}
