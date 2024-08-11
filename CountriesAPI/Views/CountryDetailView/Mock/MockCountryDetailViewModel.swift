//
//  MockCountryDetailViewModel.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/11/24.
//

import Foundation

class MockCountryDetailViewModel: CountryDetailViewModelInterface {
    @Published var countryDetails: CountryDetailModel?
    @Published var flagData: Data?
    @Published var coatOfArmsData: Data?
    private let countryList: CountryListModel
    private let countriesFetcher: CountriesFetchable
    required init(country: CountryListModel, countriesFetcher: CountriesFetchable) {
        self.countryList = country
        self.countriesFetcher = countriesFetcher
        self.countryDetails = mock_countryDetailModel_1
        self.flagData = Data()
        self.coatOfArmsData = Data()
    }
    
    func fetchCountryDetails() {}
    func downloadFlag(_ url: String) {}
    func downloadCoatOfArms(_ url: String) {}
    
    
}
