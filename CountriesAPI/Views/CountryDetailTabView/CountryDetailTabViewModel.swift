//
//  CountryDetailTabViewModel.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/19/24.
//

import Foundation

protocol CountryDetailTabViewModelInterface: ObservableObject {
    
    var activeTab: Int { get set }
    var countryDetails: CountryDetailModel { get set }
    var bookmarkManager: any BookmarkManagerInterface { get set }
    
    init(activeTab: Int, country: CountryDetailModel, bookmarkManager: any BookmarkManagerInterface)
    func mapButtonTapped()
}

class CountryDetailTabViewModel {
    @Published var activeTab: Int
    @Published var countryDetails: CountryDetailModel
    @Published var bookmarkManager: any BookmarkManagerInterface
    
    required init(activeTab: Int = 0, country: CountryDetailModel, bookmarkManager: any BookmarkManagerInterface) {
        self.activeTab = activeTab
        self.countryDetails = country
        self.bookmarkManager = bookmarkManager
    }
}

extension CountryDetailTabViewModel: CountryDetailTabViewModelInterface { 
    
    func mapButtonTapped() {
        activeTab = 1
    }
}
