//
//  CountriesListViewModel.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/10/24.
//

import Foundation
import Combine

protocol CountriesListViewModelInterface: ObservableObject {
    var countryList: [CountryListModel] { get set }
    var filteredCountryList: [CountryListModel] { get set }
    var flagList: [String: Data?] { get set }
    var searchableText: String { get set }
    init(countriesFetcher: CountriesFetchable)
    func fetchCountryList()
    func downloadFlag(_ url: String)
}

class CountryListViewModel {
    @Published var countryList: [CountryListModel]
    @Published var filteredCountryList: [CountryListModel]
    @Published var flagList: [String : Data?]
    @Published var searchableText: String
    private let countriesFetcher: CountriesFetchable
    private var disposables = Set<AnyCancellable>()
    
    required init(countriesFetcher: CountriesFetchable) {
        self.countriesFetcher = countriesFetcher
        self.countryList = [CountryListModel]()
        self.filteredCountryList = [CountryListModel]()
        self.flagList = [String: Data?]()
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

extension CountryListViewModel: CountriesListViewModelInterface {
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
    
    func downloadFlag(_ url: String) {
        countriesFetcher
            .downloadFlag(url)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                switch value {
                case .failure:
                    self?.flagList[url] = nil
                case .finished:
                    break
                }
            } receiveValue: { [weak self] imageData in
                self?.flagList[url] = imageData
            }
            .store(in: &disposables)
    }
}
