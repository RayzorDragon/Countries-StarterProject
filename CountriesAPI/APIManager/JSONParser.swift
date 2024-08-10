//
//  JSONParser.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/10/24.
//

import Foundation
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, APIError> {
    let decoder = JSONDecoder()
    decoder.dataDecodingStrategy = .deferredToData
    
    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
                .parsing(message: error.localizedDescription)
        }
        .eraseToAnyPublisher()
}
