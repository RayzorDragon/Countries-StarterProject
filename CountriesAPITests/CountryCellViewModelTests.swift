//
//  CountryCellViewModelTests.swift
//  CountriesAPITests
//
//  Created by Raymond Gatz on 8/13/24.
//

import XCTest
import Combine
@testable import CountriesAPI

final class CountryCellViewModelTests: XCTestCase {
    
    var APIFetcher: MockCountriesAPIManager<[CountryDetailModel]>?
    var viewModel: CountryCellViewModel?
    var bookmarkManager: BookmarkManager?
    private var disposables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        APIFetcher = MockCountriesAPIManager()
        bookmarkManager = BookmarkManager()
        viewModel = CountryCellViewModel(country: mock_countryDetailModel_4, countriesFetcher: APIFetcher!, bookmarkManager: bookmarkManager!, showBookmark: true)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        APIFetcher = nil
        bookmarkManager?.resetBookmarks()
        bookmarkManager = nil
        viewModel = nil
    }
    
    // 1 test
    
    // downloadFlag 
    func testDownloadFlag() throws {
        let expectation = expectation(description: "Download Flag expectation")
        
        var expectedValue1 = mock_countryDetailModel_4.flags!
        let expectedValue2 = Data()
        expectedValue1.pngData = expectedValue2
        
        APIFetcher?.expectation = expectation
        APIFetcher?.mockDataResult = expectedValue2
        
        viewModel!.downloadFlag(expectedValue1)
        
        
    
        wait(for: [expectation], timeout: 4)
        XCTAssertEqual(expectedValue1, viewModel?.country.flags)
    }
    
    func testDisplayBookmark() throws {
        
        let expectedValue1 = mock_countryDetailModel_4.name!.official!
        
        let returnedValue1 = viewModel!.displayBookmark()
        
        XCTAssertFalse(returnedValue1) // nothing saved yet for bookmarking
        
        bookmarkManager?.saveOrDeleteEntry(officalName: expectedValue1)
        
        let returnedValue2 = viewModel!.displayBookmark()
        
        XCTAssertTrue(returnedValue2) // saved
        
        // now tear down and remake to test persistant storage
        
        viewModel = nil
        bookmarkManager = nil
        
        bookmarkManager = BookmarkManager()
        viewModel = CountryCellViewModel(country: mock_countryDetailModel_4, countriesFetcher: APIFetcher!, bookmarkManager: bookmarkManager!, showBookmark: true)
        
        let returnedValue3 = viewModel!.displayBookmark()
        
        XCTAssertTrue(returnedValue3)
        
        // remake view model again to test if showBookmark false is also working
        
        viewModel = CountryCellViewModel(country: mock_countryDetailModel_4, countriesFetcher: APIFetcher!, bookmarkManager: bookmarkManager!, showBookmark: false)
        
        let returnedValue4 = viewModel!.displayBookmark()
        
        XCTAssertFalse(returnedValue4)
        
    }
}
