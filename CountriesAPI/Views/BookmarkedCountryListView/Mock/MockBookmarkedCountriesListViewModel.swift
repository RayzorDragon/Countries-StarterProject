//
//  MockBookmarkedCountriesListViewModel.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/15/24.
//

import Foundation

class MockBookmarkedCountriesListViewModel: BookmarkedCountriesListViewModelInterface {
    var countryList: [CountryDetailModel]
    var bookmarkedCountrylist: [CountryDetailModel]
    var bookmarkManager: any BookmarkManagerInterface
    
    required init(countriesFetcher: any CountriesFetchable, bookmarkManager: any BookmarkManagerInterface) {
        self.countryList = []
        self.bookmarkedCountrylist = []
        self.bookmarkManager = bookmarkManager
    }
    
    func fetchBookmarkedCountryList() { }
    
    
}
