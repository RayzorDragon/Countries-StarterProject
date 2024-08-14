//
//  CountriesAPIApp.swift
//  CountriesAPI
//
//  Created by Choudhary, Alok on 9/6/23.
//

import SwiftUI

@main
struct CountriesAPIApp: App {
    let viewModel = CountriesListViewModel(countriesFetcher: CountriesAPIManager())
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                CountriesListView(viewModel: viewModel)
            }
        }
    }
}
