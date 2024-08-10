//
//  CountriesAPI.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/10/24.
//

import Foundation
import Combine

protocol CountriesFetchable {
    func fetchCountriesList() -> AnyPublisher<[CountryListModel], APIError>
    func downloadFlag(_ url: String) -> AnyPublisher<Data,APIError>
}

class CountryAPI {
    private let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }
}

private extension CountryAPI {
    struct CountryAPIComponent {
        static let scheme = "https"
        static let host = "restcountries.com"
        static let path = "/v3.1/all"
    }
    
    func urlComponentsForCountryList() -> URLComponents {
        var components = URLComponents()
        components.scheme = CountryAPIComponent.scheme
        components.host = CountryAPIComponent.host
        components.path = CountryAPIComponent.path
        
        return components
    }
    
    func urlComponentToDownloadFlag(_ url: String) throws -> URLComponents {
        guard var components = URLComponents(string: url) else {
            throw APIError.request(message: "Invalid URL")
        }
        
        return components
    }
    
}
    
extension CountryAPI: CountriesFetchable, Fetchable, Downloadable {
    
    func fetchCountriesList() -> AnyPublisher<[CountryListModel], APIError> {
        return fetch(with: self.urlComponentsForCountryList(), session: self.session)
    }
    
    func downloadFlag(_ url: String) -> AnyPublisher<Data, APIError> {
        return downloadData(with: try? self.urlComponentToDownloadFlag(url), session: self.session)
    }
    
}
