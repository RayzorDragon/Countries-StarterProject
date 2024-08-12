//
//  CountryDetailView.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/11/24.
//

import SwiftUI

struct CountryDetailView <Model>: View where Model:CountryDetailViewModelInterface {
    
    @StateObject private var viewModel: Model
    init (viewModel: Model) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            flagView()
            countryNameView()
            capitalView()
            regionView()
            subRegionView()
            languagesView()
            currenciesView()
            populationView()
            carDriverSideView()
            coatOfArmsView()
            Spacer()
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width)
        .onAppear {
            if viewModel.countryDetails.flags.pngData == nil {
                viewModel.downloadFlag(viewModel.countryDetails.flags)
            }
            if viewModel.countryDetails.coatOfArms.pngData == nil {
                viewModel.downloadCoatOfArms(viewModel.countryDetails.coatOfArms)
            }
            
                
        }
        .navigationTitle(Text(viewModel.countryDetails.commonName()))
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder func flagView() -> some View {
        Image(uiImage: UIImage(data: (viewModel.countryDetails.flags.pngData ?? Data())!) ?? UIColor.gray.image())
            .resizable()
            .aspectRatio(contentMode: .fit)
            .border(.gray, width: 1.0)
            .frame(width: UIScreen.main.bounds.width/3.0, height: UIScreen.main.bounds.width/4.0)
            .padding(.trailing, 0.0)
    }
    
    @ViewBuilder func countryNameView() -> some View {
        HStack(spacing: 16.0) {
            Text(viewModel.countryDetails.commonName())
                .font(countryDetailCommonNameFont())
                .foregroundStyle(blackColorCountryDetailsCommonName())
                .layoutPriority(1.0)
            Text(viewModel.countryDetails.officialName())
                .font(countryDetailGenericInfoFont())
                .foregroundStyle(grayColorCountryDetailsOfficalName())
            
        }
    }
    
    @ViewBuilder func capitalView() -> some View {
        genericTextView(string1: "Capital", string2: viewModel.countryDetails.firstCapital())
    }
    
    @ViewBuilder func regionView() -> some View {
        genericTextView(string1: "Region", string2: viewModel.countryDetails.areaRegion())
    }
    
    @ViewBuilder func subRegionView() -> some View {
        genericTextView(string1: "Subregion", string2: viewModel.countryDetails.areaSubregion())
    }
    
    @ViewBuilder func languagesView() -> some View {
        genericTextView(string1: "Languages", string2: viewModel.listLanguages())
    }
    
    @ViewBuilder func currenciesView() -> some View {
        genericTextView(string1: "Currencies", string2: viewModel.listCurrency())
    }
    
    @ViewBuilder func populationView() -> some View {
        genericTextView(string1: "Population", string2: viewModel.countryDetails.populationString())
    }
    
    @ViewBuilder func carDriverSideView() -> some View {
        genericTextView(string1: "Car Driver Side", string2: viewModel.countryDetails.driverSide())
    }

    @ViewBuilder func genericTextView(string1: String, string2: String) -> some View {
        HStack(spacing: 4.0) {
            Text(string1)
                .font(countryDetailGenericTitleFont())
                .foregroundStyle(grayColorCountryDetailsTitle())
            Text("-")
                .font(countryDetailGenericTitleFont())
                .foregroundStyle(grayColorCountryDetailsTitle())
            Text(string2)
                .font(countryDetailGenericInfoFont())
                .foregroundStyle(grayColorCountryDetailsInfo())
        }
    }
    
    // Coat of Arms
    @ViewBuilder func coatOfArmsView() -> some View {
        VStack(alignment: .leading) {
            Text("Coat of Arms")
                .font(countryDetailGenericTitleFont())
                .foregroundStyle(grayColorCountryDetailsTitle())
            Image(uiImage: UIImage(data: (viewModel.countryDetails.coatOfArms.pngData ?? Data())!) ?? UIColor.gray.image())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width/8.0, height: UIScreen.main.bounds.width/6.0)
                .padding(.trailing, 0.0)
        }
    }
}

#Preview {
    CountryDetailView(viewModel: MockCountryDetailViewModel(country: mock_countryDetailModel_1, countriesFetcher: CountryAPI()))
}
