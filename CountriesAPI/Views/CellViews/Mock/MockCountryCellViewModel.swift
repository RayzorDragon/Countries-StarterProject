//
//  MockCountryCellViewModel.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/12/24.
//

import Foundation

class MockCountryCellViewModel: CountryCellViewModelInterface {
    @Published var country: CountryDetailModel
    private let countriesFetcher: CountriesFetchable
    
    required init(country: CountryDetailModel, countriesFetcher: any CountriesFetchable) {
        self.countriesFetcher = countriesFetcher
        self.country = country
    }
    
    func downloadFlag(_ sourceModel: ImageSourceModel) { }
    
    
}
