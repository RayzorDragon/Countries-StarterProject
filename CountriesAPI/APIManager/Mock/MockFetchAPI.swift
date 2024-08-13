//
//  MockFetchAPI.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/13/24.
//

import Foundation
import Combine
import XCTest

protocol MockFetchable {
    func mockFetch<T>(with urlComponent: URLComponents?, mockResult: T?, or mockError: APIError?, with exceptation: XCTestExpectation?) -> AnyPublisher<T,APIError> where T: Decodable
    
}

extension MockFetchable {
    
    func mockFetch<T>(with urlComponent: URLComponents?, mockResult: T?, or mockError: APIError?, with expectation: XCTestExpectation?) -> AnyPublisher<T,APIError> where T: Decodable {
        
        guard (urlComponent?.url) != nil else {
            expectation?.fulfill()
            return Fail(error: APIError.request(message: "Invalid URL")).eraseToAnyPublisher()
        }
        
        if let mockErrorResponse = mockError {
            expectation?.fulfill()
            return Fail(error: mockErrorResponse)
                .eraseToAnyPublisher()
        }
        
        guard let mockResponse = mockResult else {
            expectation?.fulfill()
            return Fail(error: APIError.status(message: "Invalid Status Code"))
                .eraseToAnyPublisher()
        }
        
        expectation?.fulfill()
        return Just(mockResponse)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
}
