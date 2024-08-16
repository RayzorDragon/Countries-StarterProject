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
    @Published var showBookmark: Bool
    private let countriesFetcher: CountriesFetchable
    
    required init(country: CountryDetailModel, countriesFetcher: any CountriesFetchable, bookmarkManager: any BookmarkManagerInterface, showBookmark: Bool) {
        self.countriesFetcher = countriesFetcher
        self.country = country
        self.bookmarkManager = bookmarkManager
        self.showBookmark = showBookmark
    }
    
    func downloadFlag(_ sourceModel: ImageSourceModel) { }
    func displayBookmark() -> Bool { true }
    
    
}
