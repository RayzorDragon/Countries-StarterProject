//
//  TabNavigationManagerTests.swift
//  CountriesAPITests
//
//  Created by Raymond Gatz on 8/16/24.
//

import XCTest
import Foundation
@testable import CountriesAPI

final class TabNavigationManagerTests: XCTestCase {
    
    var APIManager: MockCountriesAPIManager<[CountryDetailModel]>?
    var bookmarkManager: BookmarkManager?
    var tabManager: TabNavigationManager?
    var listViewModel: CountriesListViewModel?
    var bookmarkViewModel: BookmarkedCountriesListViewModel?
    
    override func setUpWithError() throws {
        APIManager = MockCountriesAPIManager()
        bookmarkManager = BookmarkManager()
        listViewModel = CountriesListViewModel(countriesFetcher: APIManager!, bookmarkManager: bookmarkManager!)
        bookmarkViewModel = BookmarkedCountriesListViewModel(countriesFetcher: APIManager!, bookmarkManager: bookmarkManager!)
        tabManager = TabNavigationManager(listManager: listViewModel!, bookmarkManager: bookmarkViewModel!)
    }
    
    override func tearDownWithError() throws {
        APIManager = nil
        bookmarkManager?.resetBookmarks()
        bookmarkManager = nil
        listViewModel = nil
        bookmarkViewModel = nil
        tabManager = nil
    }
    
    func testActiveTabPassingInfoBetweenViewModels() throws {
        
        let expectedValue0 = [CountryDetailModel]()
        let expectedValue1 = [mock_countryDetailModel_1]
        let expectedValue2 = [mock_countryDetailModel_2, mock_countryDetailModel_3]
        
        let returnedValue0_list = listViewModel!.countryList
        let returnedValue0_bookmark = bookmarkViewModel!.countryList
        
        XCTAssertEqual(expectedValue0, returnedValue0_list)
        XCTAssertEqual(expectedValue0, returnedValue0_bookmark)
        
        listViewModel?.countryList = expectedValue1
        tabManager?.activeTab = 1
        let returnedValue1 = bookmarkViewModel!.countryList
        
        XCTAssertEqual(expectedValue1, returnedValue1)
        
        bookmarkViewModel?.countryList = expectedValue2
        tabManager?.activeTab = 0
        let returnedValue2 = listViewModel!.countryList
        
        XCTAssertEqual(expectedValue2, returnedValue2)
        
    }
}
