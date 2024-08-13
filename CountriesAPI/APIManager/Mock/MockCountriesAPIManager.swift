//
//  MockCountriesAPIManager.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/13/24.
//

import Foundation
import Combine

class MockCountriesAPIManager<T: Decodable> {
    let mockFetchResult: T? = nil
    let mockDataResult: Data? = nil
    let mockError: APIError? = nil
}

extension MockCountriesAPIManager: CountriesFetchable, MockFetchable, MockDownloadable, URLManager {
    
    func fetchCountriesList() -> AnyPublisher<[CountryDetailModel], APIError> {
        return mockFetch(with: self.urlComponentsForCountryList(), mockResult: (mockFetchResult as? [CountryDetailModel]), or: mockError)
    }
    
    func downloadImage(_ sourceModel: ImageSourceModel) -> AnyPublisher<Data, APIError> {
        return mockDownloadData(with: try? self.urlComponentToDownloadImage(sourceModel), mockResult: mockDataResult, or: mockError)
    }
    
    func fetchCountryDetails(_ country: CountryDetailModel) -> AnyPublisher<[CountryDetailModel], APIError> {
        return mockFetch(with: self.urlComponentsForCountryDetails(country: country), mockResult: (mockFetchResult as? [CountryDetailModel]), or: mockError)
    }
    
    
}
