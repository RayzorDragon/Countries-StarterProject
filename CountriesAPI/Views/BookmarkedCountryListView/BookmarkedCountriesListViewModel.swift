//
//  BookmarkedCountriesListViewModel.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/15/24.
//

import Foundation
import Combine

protocol BookmarkedCountriesListViewModelInterface: ObservableObject {
    var countryList: [CountryDetailModel] { get set }
    var bookmarkedCountrylist: [CountryDetailModel] { get set }
    var bookmarkManager: any BookmarkManagerInterface { get set }
    init(countriesFetcher: CountriesFetchable, bookmarkManager: any BookmarkManagerInterface)
    func fetchBookmarkedCountryList()
    
}

class BookmarkedCountriesListViewModel {
    @Published var countryList: [CountryDetailModel]
    @Published var bookmarkedCountrylist: [CountryDetailModel]
    @Published var bookmarkManager: any BookmarkManagerInterface
    private let countriesFetcher: CountriesFetchable
    private var disposables = Set<AnyCancellable>()
    
    required init(countriesFetcher: CountriesFetchable, bookmarkManager: any BookmarkManagerInterface) {
        self.countriesFetcher = countriesFetcher
        self.bookmarkManager = bookmarkManager
        self.countryList = [CountryDetailModel]()
        self.bookmarkedCountrylist = [CountryDetailModel]()
    }
}

extension BookmarkedCountriesListViewModel: BookmarkedCountriesListViewModelInterface {
    func fetchBookmarkedCountryList() {
        bookmarkedCountrylist = []
        for bookmark in bookmarkManager.bookmarkedCountries {
            for country in countryList {
                if country.officialName() == bookmark {
                    bookmarkedCountrylist.append(country)
                    break
                }
            }
        }
    }
}
