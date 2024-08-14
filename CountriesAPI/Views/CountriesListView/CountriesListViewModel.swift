//
//  CountriesListViewModel.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/10/24.
//

import Foundation
import Combine

protocol CountriesListViewModelInterface: ObservableObject {
    var countryList: [CountryDetailModel] { get set }
    var filteredCountryList: [CountryDetailModel] { get set }
    var searchableText: String { get set }
    init(countriesFetcher: CountriesFetchable)
    func fetchCountryList()
}



class CountriesListViewModel {
    @Published var countryList: [CountryDetailModel]
    @Published var filteredCountryList: [CountryDetailModel]
    @Published var searchableText: String
    private let countriesFetcher: CountriesFetchable
    private var disposables = Set<AnyCancellable>()
    
    required init(countriesFetcher: CountriesFetchable) {
        self.countriesFetcher = countriesFetcher
        self.countryList = [CountryDetailModel]()
        self.filteredCountryList = [CountryDetailModel]()
        self.searchableText = ""
        
        $searchableText
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            .removeDuplicates()
            .map({ (string) -> String? in
                if string.count < 2 {
                    self.filteredCountryList = self.countryList
                    return nil
                }
                
                return string
            })
            .compactMap{ $0 }
            .sink { (_) in
                
            } receiveValue: { [self] (searchField) in
                
                self.filteredCountryList = countryList.filter({ countryModel in
                    return countryModel.commonName().hasPrefix(searchField) || countryModel.officialName().hasPrefix(searchField)
                })
            }.store(in: &disposables)
    }
}

extension CountriesListViewModel: CountriesListViewModelInterface {
    func fetchCountryList() {
        countriesFetcher
            .fetchCountriesList()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                switch value {
                case .failure:
                    self?.countryList = []
                case .finished:
                    break
                }
            } receiveValue: { [weak self] countriesResponse in
                self?.countryList = countriesResponse
            }
            .store(in: &disposables)
    }
}
