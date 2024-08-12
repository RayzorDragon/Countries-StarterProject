//
//  MockCountryDetailsModels.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/11/24.
//

import Foundation

let mock_countryDetailModel_1 =
CountryDetailModel(
    name: CountryNameModel(
        common: "Italy",
        official: "Italian Republic"),
    capital: ["Rome"],
    flags: ImageSourceModel(
        png: "https://flagcdn.com/w320/it.png"),
    region: "Europe",
    subregion: "Southern Europe",
    languages: ["ita" : "Italian"],
    currencies: ["EUR" : CurrencyModel(
        name: "Euro",
        symbol: "€")],
    population: 59554023,
    car: CarModel(side: "right"),
    coatOfArms: ImageSourceModel(
        png: "https://mainfacts.com/media/images/coats_of_arms/it.png"))
