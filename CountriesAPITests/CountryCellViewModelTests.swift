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
    private var disposables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        APIFetcher = MockCountriesAPIManager()
        viewModel = CountryCellViewModel(country: mock_countryDetailModel_4, countriesFetcher: APIFetcher!)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        APIFetcher = nil
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
}
