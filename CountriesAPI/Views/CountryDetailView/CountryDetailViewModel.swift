//
//  CountryDetailViewModel.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/11/24.
//

import Foundation
import Combine

protocol CountryDetailViewModelInterface: ObservableObject {
    var countryDetails: CountryDetailModel? { get set }
    var flagData: Data? { get set }
    var coatOfArmsData: Data? { get set }
    init(country: CountryListModel, countriesFetcher: CountriesFetchable)
    func fetchCountryDetails()
    func downloadFlag(_ url: String)
    func downloadCoatOfArms(_ url: String)
}

class CountryDetailViewModel {
    @Published var countryDetails: CountryDetailModel?
    @Published var flagData: Data?
    @Published var coatOfArmsData: Data?
    private let countryList: CountryListModel
    private let countriesFetcher: CountriesFetchable
    private var disposables = Set<AnyCancellable>()
    
    required init(country: CountryListModel, countriesFetcher: CountriesFetchable) {
        self.countryList = country
        self.countriesFetcher = countriesFetcher
        self.countryDetails = nil
        self.flagData = nil
        self.coatOfArmsData = nil
    }
}

extension CountryDetailViewModel: CountryDetailViewModelInterface {
    
    func fetchCountryDetails() {
        countriesFetcher
            .fetchCountryDetails(self.countryList)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                switch value {
                case .failure:
                    self?.countryDetails = nil
                case .finished:
                    break
                }
            } receiveValue: { [weak self] detailResponse in
                self?.countryDetails = detailResponse
            }
            .store(in: &disposables)
    }
    
    func downloadFlag(_ url: String) {
        countriesFetcher
            .downloadImage(url)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                switch value {
                case .failure:
                    self?.flagData = nil
                case .finished:
                    break
                }
            } receiveValue: { [weak self] imageData in
                self?.flagData = imageData
            }
            .store(in: &disposables)
    }
    
    func downloadCoatOfArms(_ url: String) {
        countriesFetcher
            .downloadImage(url)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                switch value {
                case .failure:
                    self?.coatOfArmsData = nil
                case .finished:
                    break
                }
            } receiveValue: { [weak self] imageData in
                self?.coatOfArmsData = imageData
            }
            .store(in: &disposables)
    }
    
    
}
