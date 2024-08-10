//
//  CountriesListModel.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/10/24.
//

import Foundation

struct CountryListModel: Codable, Identifiable {
    let id: UUID = UUID()
    var name: CountryNameModel
    var capital: [String]?
    var flags: CountryFlagModel
    
    func officialName() -> String {
        return name.official ?? ""
    }
    
    func commonName() -> String {
        return name.common ?? ""
    }
    
    func flagURL() -> String {
        return flags.png ?? ""
    }
    
    func firstCapital() -> String {
        guard let first = capital?.first else { return "" }
        return first
    }
}

struct CountryNameModel: Codable {
    var common: String?
    var official: String?
}

struct CountryFlagModel: Codable {
    var png: String?
    var svg: String?
}

