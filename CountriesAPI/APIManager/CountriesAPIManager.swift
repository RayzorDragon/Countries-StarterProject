//
//  CountriesAPIManager.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/10/24.
//

import Foundation
import Combine

protocol CountriesFetchable {
    func fetchCountriesList() -> AnyPublisher<[CountryDetailModel], APIError>
    func downloadImage(_ sourceModel: ImageSourceModel) -> AnyPublisher<Data,APIError>
    func fetchCountryDetails(_ country: CountryDetailModel) -> AnyPublisher<[CountryDetailModel], APIError>
}

class CountriesAPIManager {
    private let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }
}
    
extension CountriesAPIManager: CountriesFetchable, Fetchable, Downloadable, URLManager {
    
    func fetchCountriesList() -> AnyPublisher<[CountryDetailModel], APIError> {
        return fetch(with: self.urlComponentsForCountryList(), session: self.session)
    }
    
    func downloadImage(_ sourceModel: ImageSourceModel) -> AnyPublisher<Data, APIError> {
        return downloadData(with: try? self.urlComponentToDownloadImage(sourceModel), session: self.session)
    }
    
    func fetchCountryDetails(_ country: CountryDetailModel) -> AnyPublisher<[CountryDetailModel], APIError> {
        return fetch(with: self.urlComponentsForCountryDetails(country: country), session: self.session)
    }
    
}
