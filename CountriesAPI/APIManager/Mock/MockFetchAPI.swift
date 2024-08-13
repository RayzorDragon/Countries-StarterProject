//
//  MockFetchAPI.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/13/24.
//

import Foundation
import Combine

protocol MockFetchable {
    func mockFetch<T>(with urlComponent: URLComponents?, mockResult: T?, or mockError: APIError?) -> AnyPublisher<T,APIError> where T: Decodable
    
}

extension MockFetchable {
    
    func mockFetch<T>(with urlComponent: URLComponents?, mockResult: T?, or mockError: APIError?) -> AnyPublisher<T,APIError> where T: Decodable {
        
        guard (urlComponent?.url) != nil else {
            return Fail(error: APIError.request(message: "Invalid URL")).eraseToAnyPublisher()
        }
        
        if let mockErrorResponse = mockError {
            return Fail(error: mockErrorResponse)
                .eraseToAnyPublisher()
        }
        
        guard let mockResponse = mockResult else {
            return Fail(error: APIError.status(message: "Invalid Status Code"))
                .eraseToAnyPublisher()
        }
        
        return Just(mockResponse)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
}
