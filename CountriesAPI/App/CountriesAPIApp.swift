//
//  CountriesAPIApp.swift
//  CountriesAPI
//
//  Created by Choudhary, Alok on 9/6/23.
//

import SwiftUI

@main
struct CountriesAPIApp: App {
    @ObservedObject private var tabManager: TabNavigationManager
    let bookmarkManager: BookmarkManager
    let listViewModel: CountriesListViewModel
    let bookmarkedViewModel: BookmarkedCountriesListViewModel
    
    init() {
        bookmarkManager = BookmarkManager()
        listViewModel = CountriesListViewModel(countriesFetcher: CountriesAPIManager(), bookmarkManager: bookmarkManager)
        bookmarkedViewModel = BookmarkedCountriesListViewModel(countriesFetcher: CountriesAPIManager(), bookmarkManager: bookmarkManager)
        tabManager = TabNavigationManager(listManager: listViewModel, bookmarkManager: bookmarkedViewModel)
        
    }
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $tabManager.activeTab) {
                NavigationStack {
                    CountriesListView(viewModel: listViewModel)
                }
                .tabItem {
                    Text("Search")
                    Image(systemName: "magnifyingglass")
                }
                .tag(0)
                NavigationStack {
                    BookmarkedCountriesListView(viewModel: bookmarkedViewModel)
                }
                .tabItem {
                    Text("Saved")
                    Image(systemName: "star")
                        .environment(\.symbolVariants, .none)
                }
                .tag(1)
            }
        }
    }
}
