//
//  MockDownloadAPI.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/13/24.
//

import Foundation
import Combine
import XCTest

protocol MockDownloadable {
    func mockDownloadData(with urlComponent: URLComponents?, mockResult: Data?, or mockError: APIError?, with expectation: XCTestExpectation?) -> AnyPublisher<Data,APIError>
    
}

extension MockDownloadable {
    
    func mockDownloadData(with urlComponent: URLComponents?, mockResult: Data?, or mockError: APIError?, with expectation: XCTestExpectation?) -> AnyPublisher<Data,APIError> {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            expectation?.fulfill()
        }
        
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
