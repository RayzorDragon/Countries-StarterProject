//
//  CountryDetailModel.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/10/24.
//

import Foundation

struct CountryDetailModel: Codable, Identifiable {
    let id: UUID = UUID()
    var name: CountryNameModel?
    var capital: [String]?
    var flags: ImageSourceModel?
    var region: String?
    var subregion: String?
    var languages: [String: String]?
    var currencies: [String: CurrencyModel]?
    var population: Int?
    var car: CarModel?
    var coatOfArms: ImageSourceModel?
    var area: Float?
    var timezones: [String]?
    
    func officialName() -> String {
        return name?.official ?? ""
    }
    
    func commonName() -> String {
        return name?.common ?? ""
    }
    
    func flagURL() -> String {
        return flags?.png ?? ""
    }
    
    func firstCapital() -> String {
        guard let first = capital?.first else { return "" }
        return first
    }
    
    func areaRegion() -> String {
        return region ?? ""
    }
    
    func areaSubregion() -> String {
        return subregion ?? ""
    }
    
    func allLanguages() -> [String:String] {
        return languages ?? [:]
    }
    
    func allCurrencies() -> [String:CurrencyModel] {
        return currencies ?? [:]
    }
    
    func populationString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: population ?? 0)) ?? "0"
    }
    
    func areaString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: area ?? 0)) ?? "0"
    }
    
    func driverSide() -> String {
        return car?.side ?? ""
    }
    
    func coatOfArmsURL() -> String {
        return coatOfArms?.png ?? ""
    }
}

extension CountryDetailModel: Equatable {
    static func == (lhs: CountryDetailModel, rhs: CountryDetailModel) -> Bool {
        lhs.id.uuidString == rhs.id.uuidString
    }
    
    
}

struct CountryNameModel: Codable {
    var common: String?
    var official: String?
}

struct ImageSourceModel: Codable {
    var png: String?
    var pngData: Data?
}

extension ImageSourceModel: Equatable {
    static func == (lhs: ImageSourceModel, rhs: ImageSourceModel) -> Bool {
        lhs.png == rhs.png &&
        lhs.pngData == rhs.pngData
    }
}

struct CurrencyModel: Codable {
    var name: String?
    var symbol: String?
}

struct CarModel: Codable {
    var side: String?
}
