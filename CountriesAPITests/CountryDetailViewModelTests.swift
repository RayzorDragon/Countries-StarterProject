//
//  CountryDetailViewModelTests.swift
//  CountriesAPITests
//
//  Created by Raymond Gatz on 8/13/24.
//

import XCTest
import Combine
@testable import CountriesAPI

final class CountryDetailViewModelTests: XCTestCase {
    
    var APIFetcher: MockCountriesAPIManager<[CountryDetailModel]>?
    var viewModel: CountryDetailViewModel?
    private var disposables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        APIFetcher = MockCountriesAPIManager()
        viewModel = CountryDetailViewModel(country: mock_countryDetailModel_3, countriesFetcher: APIFetcher!)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        APIFetcher = nil
        viewModel = nil
    }
    
    
    // 4 tests
    
    // downloadFlag
    func testDownloadFlag() throws {
        let expectation = expectation(description: "Download Flag expectation")
        
        var expectedValue1 = viewModel?.countryDetails.flags
        let expectedValue2 = Data()
        expectedValue1?.pngData = expectedValue2
        
        APIFetcher?.expectation = expectation
        APIFetcher?.mockDataResult = expectedValue2
        
        viewModel!.downloadFlag(expectedValue1!)
        
        
    
        wait(for: [expectation], timeout: 4)
        XCTAssertEqual(expectedValue1, viewModel?.countryDetails.flags)
    }
    
    // downloadCoatOfArms
    func testDownloadCoatOfArms() throws {
        let expectation = expectation(description: "Download Coat Of Arms expectation")
        
        var expectedValue1 = viewModel!.countryDetails.coatOfArms
        let expectedValue2 = Data()
        expectedValue1?.pngData = expectedValue2
        
        APIFetcher?.expectation = expectation
        APIFetcher?.mockDataResult = expectedValue2
        
        viewModel!.downloadCoatOfArms(expectedValue1!)
        
        
    
        wait(for: [expectation], timeout: 4)
        XCTAssertEqual(expectedValue1, viewModel?.countryDetails.coatOfArms)
    }
    
    // listLanguages
    
    func testListLanguages() throws {
        // as we can never be certain in what order an array might be processed, we have no means of ensuring which languages will be first when presented. Consider asking if there is a prefered way to sort language array.
        let expectedValue = viewModel?.countryDetails.languages!.values
        
        let returnedValue = viewModel!.listLanguages()
        
        // does the returned value have info?
        XCTAssertFalse(returnedValue.isEmpty)
        
        // split returned values by expected seperator
        let returnedArray = returnedValue.components(separatedBy: ", ")
        
        // same counts
        XCTAssertEqual(returnedArray.count, expectedValue?.count)
        
        // sort data
        let expectedSort = expectedValue?.sorted(by: { $0.lowercased() < $1.lowercased() })
        let returnedSort = returnedArray.sorted(by: { $0.lowercased() < $1.lowercased() })
        
        // assert first entry is the same in both lists
        XCTAssertTrue(expectedSort![0] == returnedSort[0])
        
    }
    
    // listCurrency
    func testListCurrency() throws {
        // while current logic can handle multiple different currencies similar to the language listing system, no countries in data set provide multiple currencies for real world testing.
        
        let expectedData = viewModel?.countryDetails.currencies?.first
        let expectedKey = expectedData?.key
        let expectedName = expectedData?.value.name!
        let expectedValue = "\(expectedKey!) (\(expectedName!))"
        let returnedValue = viewModel?.listCurrency()
        
        XCTAssertEqual(expectedValue, returnedValue)
    }
}
