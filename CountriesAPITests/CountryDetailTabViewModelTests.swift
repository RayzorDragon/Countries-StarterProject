//
//  CountryDetailTabViewModelTests.swift
//  CountriesAPITests
//
//  Created by Raymond Gatz on 8/22/24.
//

import XCTest
import Foundation
@testable import CountriesAPI

final class CountryDetailTabViewModelTests: XCTestCase {
    
    var bookmarkManager: BookmarkManager?
    var viewModel: CountryDetailTabViewModel?
    
    override func setUpWithError() throws {
        bookmarkManager = BookmarkManager()
        viewModel = CountryDetailTabViewModel(country: mock_countryDetailModel_4, bookmarkManager: bookmarkManager!)
    }
    
    override func tearDownWithError() throws {
        bookmarkManager?.resetBookmarks()
        bookmarkManager = nil
        viewModel = nil
    }
    
    func testMapTap() throws {
        
        let expectedData = 1
        let unalteredData = 0
        
        let returnedUnalteredData = viewModel?.activeTab
        
        XCTAssertEqual(returnedUnalteredData, unalteredData)
        
        viewModel?.mapButtonTapped()
        
        let returnedAlteredData = viewModel?.activeTab
        XCTAssertEqual(returnedAlteredData, expectedData)
        
        
        
    }
}
