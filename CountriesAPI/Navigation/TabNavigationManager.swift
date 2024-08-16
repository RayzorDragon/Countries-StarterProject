//
//  TabNavigationManager.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/16/24.
//

import Foundation

class TabNavigationManager: ObservableObject {
    @Published var activeTab: Int {
        willSet {
            if activeTab == 0 && newValue == 1 {
                bookmarkManager.countryList = listManager.countryList
            } else if activeTab == 1 && newValue == 0 {
                listManager.countryList = bookmarkManager.countryList
            }
        }
    }
    @Published var listManager: any CountriesListViewModelInterface
    @Published var bookmarkManager: any BookmarkedCountriesListViewModelInterface
    
    init(activeTab: Int = 0, listManager: any CountriesListViewModelInterface, bookmarkManager: any BookmarkedCountriesListViewModelInterface) {
        self.activeTab = activeTab
        self.listManager = listManager
        self.bookmarkManager = bookmarkManager
    }
}
