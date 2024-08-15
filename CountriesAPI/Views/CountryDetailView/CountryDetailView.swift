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
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 16.0) {
                    coatOfArmsView()
                    regionView()
                    subRegionView()
                    capitalView()
                    areaView()
                    HStack {
                        Spacer()
                    }
                }
                VStack(alignment: .leading, spacing: 16.0) {
                    populationView()
                    languagesView()
                    carDriverSideView()
                    currenciesView()
                    timezoneView()
                    HStack {
                        Spacer()
                    }
                    
                }
            }
            Spacer()
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width)
        .onAppear {
            if viewModel.countryDetails.flags?.pngData == nil {
                viewModel.downloadFlag(viewModel.countryDetails.flags ?? ImageSourceModel())
            }
            if viewModel.countryDetails.coatOfArms?.pngData == nil {
                viewModel.downloadCoatOfArms(viewModel.countryDetails.coatOfArms ?? ImageSourceModel())
            }
            
                
        }
        .navigationTitle(Text(viewModel.countryDetails.commonName()))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                viewModel.saveButtonTapped()
            } label: {
                Image(systemName: viewModel.bookmarked ? "bookmark.fill" : "bookmark")
            }

        }
    }
    
    @ViewBuilder func flagView() -> some View {
        Image(uiImage: UIImage(data: (viewModel.countryDetails.flags?.pngData ?? Data())!) ?? UIColor.gray.image())
            .resizable()
            .aspectRatio(contentMode: .fit)
            .border(.gray, width: 1.0)
            .frame(width: UIScreen.main.bounds.width/3.0, height: UIScreen.main.bounds.width/4.0)
            .padding(.trailing, 0.0)
    }
    
    @ViewBuilder func countryNameView() -> some View {
        VStack(alignment: .leading) {
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
        genericTextView(string1: "Language(s)", string2: viewModel.listLanguages())
    }
    
    @ViewBuilder func currenciesView() -> some View {
        genericTextView(string1: "Currencies", string2: viewModel.listCurrency())
    }
    
    @ViewBuilder func populationView() -> some View {
        genericTextView(string1: "Population", string2: viewModel.countryDetails.populationString())
    }
    
    @ViewBuilder func areaView() -> some View {
        genericTextView(string1: "Area", string2: viewModel.countryDetails.areaString())
    }
    
    @ViewBuilder func carDriverSideView() -> some View {
        
            VStack(alignment: .leading, spacing: 0.0) {
                Text("Car Driver Side")
                    .font(countryDetailGenericTitleFont())
                    .foregroundStyle(grayColorCountryDetailsTitle())
                HStack {
                    Text("Left")
                        .font(countryDetailGenericInfoFont())
                        .foregroundStyle(grayColorCountryDetailsInfo() )
                        .opacity(viewModel.driveLeftSide() ? 1.0 : 0.3)
                    Text(Image(systemName: "car.circle"))
                        .font(countryDetailGenericInfoFont())
                        .foregroundStyle(grayColorCountryDetailsTitle())
                    Text("Right")
                        .font(countryDetailGenericInfoFont())
                        .foregroundStyle(grayColorCountryDetailsInfo()).opacity(viewModel.driveRightSide() ? 1.0 : 0.3)
                }
            }
    }
    
    @ViewBuilder func timezoneView() -> some View {
        genericTextView(string1: "Timezone(s)", string2: viewModel.listTimezones())
    }

    @ViewBuilder func genericTextView(string1: String, string2: String) -> some View {
        VStack(alignment: .leading, spacing: 0.0) {
            Text(string1)
                .font(countryDetailGenericTitleFont())
                .foregroundStyle(grayColorCountryDetailsTitle())
            Text(string2)
                .font(countryDetailGenericInfoFont())
                .foregroundStyle(grayColorCountryDetailsInfo())
        }
    }
    
    // Coat of Arms
    @ViewBuilder func coatOfArmsView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Coat of Arms")
                .font(countryDetailGenericTitleFont())
                .foregroundStyle(grayColorCountryDetailsTitle())
            Image(uiImage: UIImage(data: (viewModel.countryDetails.coatOfArms?.pngData ?? Data())!) ?? UIColor.gray.image())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width/8.0, height: UIScreen.main.bounds.width/6.0)
                .padding(.trailing, 0.0)
        }
    }
}

#Preview {
    CountryDetailView(viewModel: MockCountryDetailViewModel(country: mock_countryDetailModel_1, countriesFetcher: CountriesAPIManager(), bookmarkManager: BookmarkManager()))
}
