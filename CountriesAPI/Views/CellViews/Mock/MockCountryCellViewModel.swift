//
//  MockCountryCellViewModel.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/12/24.
//

import Foundation

class MockCountryCellViewModel: CountryCellViewModelInterface {
    @Published var country: CountryDetailModel
    @Published var bookmarkManager: any BookmarkManagerInterface
    private let countriesFetcher: CountriesFetchable
    
    required init(country: CountryDetailModel, countriesFetcher: any CountriesFetchable, bookmarkManager: any BookmarkManagerInterface) {
        self.countriesFetcher = countriesFetcher
        self.country = country
        self.bookmarkManager = bookmarkManager
    }
    
    func downloadFlag(_ sourceModel: ImageSourceModel) { }
    
    
}
