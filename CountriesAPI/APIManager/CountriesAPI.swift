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
    func downloadImage(_ url: String) -> AnyPublisher<Data,APIError>
    func fetchCountryDetails(_ country: CountryListModel) -> AnyPublisher<[CountryDetailModel], APIError>
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
    
    func urlComponentToDownloadImage(_ url: String) throws -> URLComponents {
        guard let components = URLComponents(string: url) else {
            throw APIError.request(message: "Invalid URL")
        }
        
        return components
    }
    
    struct CountryDetailAPIComponent {
        static let scheme = "https"
        static let host = "restcountries.com"
        static let path = "/v3.1/name"
    }
    
    func urlComponentsForCountryDetails(country: CountryListModel) -> URLComponents {
        var components = URLComponents()
        components.scheme = CountryDetailAPIComponent.scheme
        components.host = CountryDetailAPIComponent.host
        components.path = CountryDetailAPIComponent.path + "/" + country.officialName()
        
        return components
    }
}
    
extension CountryAPI: CountriesFetchable, Fetchable, Downloadable {
    
    func fetchCountriesList() -> AnyPublisher<[CountryListModel], APIError> {
        return fetch(with: self.urlComponentsForCountryList(), session: self.session)
    }
    
    func downloadImage(_ url: String) -> AnyPublisher<Data, APIError> {
        return downloadData(with: try? self.urlComponentToDownloadImage(url), session: self.session)
    }
    
    func fetchCountryDetails(_ country: CountryListModel) -> AnyPublisher<[CountryDetailModel], APIError> {
        return fetch(with: self.urlComponentsForCountryDetails(country: country), session: self.session)
    }
    
}
