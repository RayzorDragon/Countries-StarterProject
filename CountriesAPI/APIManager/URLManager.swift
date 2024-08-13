//
//  URLManager.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/13/24.
//

import Foundation

protocol URLManager {
    func urlComponentsForCountryList() -> URLComponents
    func urlComponentToDownloadImage(_ sourceModel: ImageSourceModel) throws -> URLComponents
    func urlComponentsForCountryDetails(country: CountryDetailModel) -> URLComponents
}

struct CountryAPIComponent {
    static let scheme = "https"
    static let host = "restcountries.com"
    static let path = "/v3.1/all"
}

struct CountryDetailAPIComponent {
    static let scheme = "https"
    static let host = "restcountries.com"
    static let path = "/v3.1/name"
}

extension URLManager {
    
    func urlComponentsForCountryList() -> URLComponents {
        var components = URLComponents()
        components.scheme = CountryAPIComponent.scheme
        components.host = CountryAPIComponent.host
        components.path = CountryAPIComponent.path
        
        return components
    }
    
    func urlComponentToDownloadImage(_ sourceModel: ImageSourceModel) throws -> URLComponents {
        guard let components = URLComponents(string: sourceModel.png ?? "") else {
            throw APIError.request(message: "Invalid URL")
        }
        
        return components
    }
    
    func urlComponentsForCountryDetails(country: CountryDetailModel) -> URLComponents {
        var components = URLComponents()
        components.scheme = CountryDetailAPIComponent.scheme
        components.host = CountryDetailAPIComponent.host
        components.path = CountryDetailAPIComponent.path + "/" + (country.name?.official ?? "")
        
        return components
    }
}
