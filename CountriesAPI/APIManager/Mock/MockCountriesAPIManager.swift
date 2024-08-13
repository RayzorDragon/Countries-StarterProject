//
//  MockCountriesAPIManager.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/13/24.
//

import Foundation
import Combine
import XCTest

class MockCountriesAPIManager<T: Decodable> {
    var mockFetchResult: T? = nil
    var mockDataResult: Data? = nil
    var mockError: APIError? = nil
    var expectation: XCTestExpectation? = nil
}

extension MockCountriesAPIManager: CountriesFetchable, MockFetchable, MockDownloadable, URLManager {
    
    func fetchCountriesList() -> AnyPublisher<[CountryDetailModel], APIError> {
        return mockFetch(with: self.urlComponentsForCountryList(), mockResult: (mockFetchResult as? [CountryDetailModel]), or: mockError, with: expectation)
    }
    
    func downloadImage(_ sourceModel: ImageSourceModel) -> AnyPublisher<Data, APIError> {
        return mockDownloadData(with: try? self.urlComponentToDownloadImage(sourceModel), mockResult: mockDataResult, or: mockError, with: expectation)
    }
    
    func fetchCountryDetails(_ country: CountryDetailModel) -> AnyPublisher<[CountryDetailModel], APIError> {
        return mockFetch(with: self.urlComponentsForCountryDetails(country: country), mockResult: (mockFetchResult as? [CountryDetailModel]), or: mockError, with: expectation)
    }
    
    
}
