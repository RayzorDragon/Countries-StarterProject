//
//  CountryDetailViewModel.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/11/24.
//

import Foundation
import Combine

protocol CountryDetailViewModelInterface: ObservableObject {
    var countryDetails: CountryDetailModel { get set }
    var bookmarkManager: any BookmarkManagerInterface { get set }
    var bookmarked: Bool { get set }
    init(country: CountryDetailModel, countriesFetcher: CountriesFetchable, bookmarkManager: any BookmarkManagerInterface)
    func downloadFlag(_ sourceModel: ImageSourceModel)
    func downloadCoatOfArms(_ sourceModel: ImageSourceModel)
    func listLanguages() -> String
    func listCurrency() -> String
    func listTimezones() -> String
    func driveRightSide() -> Bool
    func driveLeftSide() -> Bool
    func saveButtonTapped()
}

extension CountryDetailViewModelInterface {
    
    func listLanguages() -> String {
        guard let languages = countryDetails.languages else { return "" }
        var languageString = ""
        
        for language in languages.values {
            if languageString.isEmpty {
                languageString = "•  " + language
            } else {
                languageString = languageString + "\n•  " + language
            }
        }
        
        return languageString
    }
    
    func listCurrency() -> String {
        guard let currencies = countryDetails.currencies else { return "" }
        var currencyString = ""
        
        for currency in currencies {
            let currencyShort = currency.key
            guard let currencyName = currency.value.name else { continue }
            guard let currencySymbol = currency.value.symbol else { continue }
            let formatting = currencyShort + " (" + currencySymbol + " " + currencyName + ")"
            if currencyString.isEmpty {
                currencyString = formatting
            } else {
                currencyString = currencyString + ", " + formatting
            }
        }
        
        return currencyString
    }
    
    func listTimezones() -> String {
        guard let zones = countryDetails.timezones else { return "" }
        var zonesString = ""
        
        for zone in zones {
            if zonesString.isEmpty {
                zonesString = zone
            } else {
                zonesString = zonesString + "\n" + zone
            }
        }
        
        return zonesString
    }
    
    func driveRightSide() -> Bool {
        return countryDetails.driverSide().lowercased() == "right"
    }
    
    func driveLeftSide() -> Bool {
        return countryDetails.driverSide().lowercased() == "left"
    }
    
}

class CountryDetailViewModel {
    @Published var countryDetails: CountryDetailModel
    @Published var bookmarkManager: any BookmarkManagerInterface
    @Published var bookmarked: Bool
    private let countriesFetcher: CountriesFetchable
    private var disposables = Set<AnyCancellable>()
    
    required init(country: CountryDetailModel, countriesFetcher: CountriesFetchable, bookmarkManager: any BookmarkManagerInterface) {
        self.countriesFetcher = countriesFetcher
        self.countryDetails = country
        self.bookmarkManager = bookmarkManager
        self.bookmarked = bookmarkManager.contains(officalName: country.officialName())
    }
}

extension CountryDetailViewModel: CountryDetailViewModelInterface {
    func downloadFlag(_ sourceModel: ImageSourceModel) {
        countriesFetcher
            .downloadImage(sourceModel)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                switch value {
                case .failure:
                    self?.countryDetails.flags?.pngData = nil
                case .finished:
                    break
                }
            } receiveValue: { [weak self] imageData in
                self?.countryDetails.flags?.pngData = imageData
            }
            .store(in: &disposables)
    }
    
    func downloadCoatOfArms(_ sourceModel: ImageSourceModel) {
        countriesFetcher
            .downloadImage(sourceModel)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                switch value {
                case .failure:
                    self?.countryDetails.coatOfArms?.pngData = nil
                case .finished:
                    break
                }
            } receiveValue: { [weak self] imageData in
                self?.countryDetails.coatOfArms?.pngData = imageData
            }
            .store(in: &disposables)
    }
    
    func saveButtonTapped() {
        bookmarkManager.saveOrDeleteEntry(officalName: countryDetails.officialName())
        bookmarked = bookmarkManager.contains(officalName: countryDetails.officialName())
    }
}
