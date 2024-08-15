//
//  MockCountryDetailViewModel.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/11/24.
//

import Foundation

class MockCountryDetailViewModel: CountryDetailViewModelInterface {
    
    @Published var countryDetails: CountryDetailModel
    private let countriesFetcher: CountriesFetchable
    required init(country: CountryDetailModel, countriesFetcher: CountriesFetchable) {
        self.countriesFetcher = countriesFetcher
        self.countryDetails = country
    }
    func downloadFlag(_ sourceModel: ImageSourceModel) {}
    func downloadCoatOfArms(_ sourceModel: ImageSourceModel) {}
    func listLanguages() -> String { return "" }
    func listCurrency() -> String { return "" }
    func listTimezones() -> String { return "" }
    
    
}
