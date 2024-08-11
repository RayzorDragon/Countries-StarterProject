//
//  MockCountriesListModels.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/10/24.
//

import Foundation

let mock_countriesListModel_1 = 
CountryListModel(
    name: CountryNameModel(
        common: "Libya",
        official: "State of Libya"),
    capital: ["Tripoli"],
    flags: ImageSourceModel(
        png: "https://flagcdn.com/w320/ly.png",
        svg: "https://flagcdn.com/ly.svg"))
