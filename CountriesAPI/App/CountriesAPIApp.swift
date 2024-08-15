//
//  CountriesAPIApp.swift
//  CountriesAPI
//
//  Created by Choudhary, Alok on 9/6/23.
//

import SwiftUI

@main
struct CountriesAPIApp: App {
    let viewModel = CountriesListViewModel(countriesFetcher: CountriesAPIManager(), bookmarkManager: BookmarkManager())
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationStack {
                    CountriesListView(viewModel: viewModel)
                }
                .tabItem {
                    Text("Search")
                    Image(systemName: "magnifyingglass")
                }
                .tag(0)
                NavigationStack {
                    Text("Saved View")
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
