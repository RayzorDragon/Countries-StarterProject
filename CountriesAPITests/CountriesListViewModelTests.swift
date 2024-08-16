//
//  CountriesListViewModelTests.swift
//  CountriesAPITests
//
//  Created by Raymond Gatz on 8/13/24.
//

import XCTest
import Combine
@testable import CountriesAPI

final class CountriesListViewModelTests: XCTestCase {
    
    var APIFetcher: MockCountriesAPIManager<[CountryDetailModel]>?
    var bookmarkManager: BookmarkManager?
    var viewModel: CountriesListViewModel?
    private var disposables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        APIFetcher = MockCountriesAPIManager()
        bookmarkManager = BookmarkManager()
        viewModel = CountriesListViewModel(countriesFetcher: APIFetcher!, bookmarkManager: bookmarkManager!)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        APIFetcher = nil
        bookmarkManager?.resetBookmarks()
        bookmarkManager = nil
        viewModel = nil
    }
    
    // 2 tests
    
    // searchableText
    func testSearchableText() throws {
        var expectedList = [
            mock_countryDetailModel_1, // Italy
            mock_countryDetailModel_2, // Sri Lanka
            mock_countryDetailModel_3, // South Africa
            mock_countryDetailModel_4, // United States
            mock_countryDetailModel_5 // United States Minor Outlying Islands
        ]
        
        viewModel?.countryList = expectedList
        
        // Start, shouldn't have any chance to filter countries that are loaded
        XCTAssertEqual([], viewModel?.filteredCountryList)
        
        // check after one second
        let expectation00 = expectation(description: "Search Filter expectation empty string")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation00.fulfill()
        }
        
        wait(for: [expectation00], timeout: 2)
        XCTAssertEqual(expectedList, viewModel?.filteredCountryList)
        
        // test for one character search not doing anything
        let expectation01 = expectation(description: "Search Filter expectation single character")
        viewModel?.searchableText = "S"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation01.fulfill()
        }
        
        wait(for: [expectation01], timeout: 2)
        XCTAssertEqual(expectedList, viewModel?.filteredCountryList)
        
        let expectation02 = expectation(description: "Search Filter expectation multiple characters")
        
        viewModel?.searchableText = "Un"
        
        let expectedFiltered = [
            mock_countryDetailModel_4,
            mock_countryDetailModel_5
        ]
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation02.fulfill()
        }
        wait(for: [expectation02], timeout: 2)
        XCTAssertEqual(expectedFiltered, viewModel?.filteredCountryList)
        let expectation03 = expectation(description: "Search Filter expectation reset")
        
        viewModel?.searchableText = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation03.fulfill()
        }
        wait(for: [expectation03], timeout: 2)
        XCTAssertEqual(expectedList, viewModel?.filteredCountryList)
        
    }
    
    // fetchCountriesList
    func testFetchCountries() throws {
        
        let expectation = expectation(description: "Fetch Countries expectation")
        
        var expectedValue = [
        mock_countryDetailModel_1,
        mock_countryDetailModel_2,
        mock_countryDetailModel_3,
        mock_countryDetailModel_4,
        mock_countryDetailModel_5
        ]
        
        APIFetcher?.expectation = expectation
        APIFetcher?.mockFetchResult = expectedValue
        
        viewModel?.fetchCountryList()
        
        wait(for: [expectation], timeout: 4)
        XCTAssertEqual(expectedValue, viewModel?.countryList)
        
    }
}
