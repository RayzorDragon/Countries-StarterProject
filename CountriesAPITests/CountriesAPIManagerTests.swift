//
//  CountriesAPIManagerTests.swift
//  CountriesAPITests
//
//  Created by Raymond Gatz on 8/13/24.
//

import XCTest
import Combine
@testable import CountriesAPI

final class CountriesAPIManagerTests: XCTestCase {
    
    var APIManager: MockCountriesAPIManager<[CountryDetailModel]>?
    private var disposables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        APIManager = MockCountriesAPIManager()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        APIManager = nil
    }
    
    // test for the three API calls? - set up mock downloader that can be fed a response to return in, providing a generic image asset as a data object. This will allow a mock APIManager to return an object that will be updated to the provided model.
    
    // fetchCountriesList
    func testFetchCountriesList() throws {
        let expectation = expectation(description: "Returned countries info")
        let expectedValues = [
            mock_countryDetailModel_1,
            mock_countryDetailModel_2,
            mock_countryDetailModel_3,
            mock_countryDetailModel_4
        ]
        
        var receivedValues = [CountryDetailModel]()
        
        APIManager!.mockFetchResult = expectedValues
        
        APIManager?.fetchCountriesList()
            .receive(on: DispatchQueue.main)
            .sink { value in
                switch value {
                case .failure:
                    receivedValues = []
                case .finished:
                    break
                }
            } receiveValue: { countriesResponse in
                receivedValues = countriesResponse
                expectation.fulfill()
            }
            .store(in: &disposables)
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(expectedValues, receivedValues)
    }
    
    // downloadImage
    
    func testDownloadImage() throws {
        let expectation = expectation(description: "Return Image Data")
        let expectedValue = Data()
        
        var receivedValue: Data?
        
        APIManager!.mockDataResult = expectedValue
        
        let sourceModel = mock_countryDetailModel_1.flags!
        
        APIManager?.downloadImage(sourceModel)
        .receive(on: DispatchQueue.main)
        .sink { value in
            switch value {
            case .failure:
                receivedValue = nil
            case .finished:
                break
            }
        } receiveValue: { imageData in
            receivedValue = imageData
            expectation.fulfill()
        }
        .store(in: &disposables)
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(expectedValue, receivedValue)
    }
    
    // fetchCountryDetails
    
    func testFetchCountryDetail() throws {
        let expectation = expectation(description: "Returned detail info")
        let expectedValues = [
            mock_countryDetailModel_4
        ]
        
        var receivedValues = [CountryDetailModel]()
        
        APIManager!.mockFetchResult = expectedValues
        
        APIManager?.fetchCountryDetails(mock_countryDetailModel_4)
            .receive(on: DispatchQueue.main)
            .sink { value in
                switch value {
                case .failure:
                    receivedValues = []
                case .finished:
                    break
                }
            } receiveValue: { detailResponse in
                receivedValues = detailResponse
                expectation.fulfill()
            }
            .store(in: &disposables)
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(expectedValues, receivedValues)
    }
}

//TODO: Test for Failure States/APIError checks, etc
