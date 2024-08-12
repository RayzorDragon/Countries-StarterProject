//
//  Fonts+Colors.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/12/24.
//

import Foundation
import SwiftUI

// Custom Colors
func blackColorCountryListNames() -> Color {
    return Color(red: (27.0/255.0), green: (27.0/255.0), blue: (29.0/255.0))
}

func blackColorCountryDetailsCommonName() -> Color {
    return Color(red: 24.0/255.0, green: 29.0/255.0, blue: 26.0/255.0)
}

func grayColorCountryListCapital() -> Color {
    return Color(red: (160.0/255.0), green: (160.0/255.0), blue: (164.0/255.0))
}

func grayColorCountryDetailsOfficalName() -> Color {
    return Color(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0)
}

func grayColorCountryDetailsTitle() -> Color {
    return Color(red: 110.0/255.0, green: 110.0/255.0, blue: 110.0/255.0)
}

func grayColorCountryDetailsInfo() -> Color {
    return Color(red: 111.0/255.0, green: 111.0/255.0, blue: 111.0/255.0)
}

// Custom Fonts

func countryListNameFont() -> Font {
    return Font.system(size: 18.0, weight: .bold)
}

func countryListOfficalFont() -> Font {
    return Font.system(size: 18.0, weight: .medium)
}

func countryListCapitalFont() -> Font {
    return Font.system(size: 14.0, weight: .light)
}

func countryDetailCommonNameFont() -> Font {
    return Font.system(size: 34.0, weight: .bold)
}

func countryDetailGenericTitleFont() -> Font {
    return Font.system(size: 18.0, weight: .semibold)
}

func countryDetailGenericInfoFont() -> Font {
    return Font.system(size: 18.0, weight: .light)
}
