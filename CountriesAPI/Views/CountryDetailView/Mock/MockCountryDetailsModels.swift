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
        png: "https://mainfacts.com/media/images/coats_of_arms/it.png"),
    area: 301336,
timezones: ["UTC+01:00"])

let mock_countryDetailModel_2 =
CountryDetailModel(
    name: CountryNameModel(
        common: "Sri Lanka",
        official: "Democratic Socialist Republic of Sri Lanka"),
    capital: ["Sri Jayawardenepura Kotte"],
    flags: ImageSourceModel(
        png: "https://flagcdn.com/w320/lk.png"),
    region: "Asia",
    subregion: "Southern Asia",
    languages: ["sin" : "Sinhala",
                "tam" : "Tamil"],
    currencies: ["LKR" : CurrencyModel(
        name: "Sri Lankan rupee",
        symbol: "Rs  රු")],
    population: 21919000,
    car: CarModel(
        side: "left"),
    coatOfArms: ImageSourceModel(
        png: "https://mainfacts.com/media/images/coats_of_arms/lk.png"),
    area: 65610,
    timezones: ["UTC+05:30"])

let mock_countryDetailModel_3 =
CountryDetailModel(
    name: CountryNameModel(
        common: "South Africa",
        official: "Republic of South Africa"),
    capital: ["Pretoria",
              "Bloemfontein",
              "Cape Town"],
    flags: ImageSourceModel(
        png: "https://flagcdn.com/w320/za.png"),
    region: "Africa",
    subregion: "Southern Africa",
    languages: ["afr" : "Afrikaans",
                "eng" : "English",
                "nbl" : "Southern Ndebele",
                "nso" : "Northern Sotho",
                "sot" : "Southern Sotho",
                "ssw" : "Swazi",
                "tsn" : "Tswana",
                "tso" : "Tsonga",
                "ven" : "Venda",
                "xho" : "Xhosa",
                "zul" : "Zulu"],
    currencies: ["ZAR" : CurrencyModel(
        name: "South African rand",
        symbol: "R")],
    population: 59308690,
    car: CarModel(
        side: "left"),
    coatOfArms: ImageSourceModel(
        png: "https://mainfacts.com/media/images/coats_of_arms/za.png"),
    area: 1221037,
    timezones: ["UTC+02:00"])

let mock_countryDetailModel_4 =
CountryDetailModel(
    name: CountryNameModel(
        common: "United States",
        official: "United States of America"),
    capital: ["Washington, D.C."],
    flags: ImageSourceModel(
        png: "https://flagcdn.com/w320/us.png"),
    region: "Americas",
    subregion: "North America",
    languages: ["eng" : "English"],
    currencies: ["USD" : CurrencyModel(
        name: "United States dollar",
        symbol: "$")],
    population: 329484123,
    car: CarModel(
        side: "right"),
    coatOfArms: ImageSourceModel(
        png: "https://mainfacts.com/media/images/coats_of_arms/us.png"),
    area: 9372610,
    timezones: ["UTC-12:00", "UTC-11:00", "UTC-10:00", "UTC-09:00", "UTC-08:00", "UTC-07:00", "UTC-06:00", "UTC-05:00", "UTC-04:00", "UTC+10:00", "UTC+12:00"])

let mock_countryDetailModel_5 =
CountryDetailModel(
    name: CountryNameModel(
        common: "United States Minor Outlying Islands",
        official: "United States Minor Outlying Islands"),
    capital: ["Washington, D.C."],
    flags: ImageSourceModel(
        png: "https://flagcdn.com/w320/us.png"),
    region: "Americas",
    subregion: "North America",
    languages: ["eng" : "English"],
    currencies: ["USD" : CurrencyModel(
        name: "United States dollar",
        symbol: "$")],
    population: 300,
    car: CarModel(
        side: "right"),
    coatOfArms: nil,
    area: 34.2,
    timezones: ["UTC-11:00", "UTC-10:00", "UTC+12:00"])
