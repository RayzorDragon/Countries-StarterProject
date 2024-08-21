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
        ScrollView {
            VStack(alignment: .leading, spacing: 0.0) {
                ZStack(alignment: .bottom) {
                    flagView()
                    HStack{
                        countryNameView()
                            .fixedSize()
                            .onTapGesture {
                                viewModel.mapButtonTapped()
                            }
                        Spacer()
                        
                    }
                    .padding(.leading, 16.0)
                    .padding(.trailing, 16.0)
                .alignmentGuide(VerticalAlignment.bottom,
                                computeValue: { d in d[VerticalAlignment.center] })
                .alignmentGuide(HorizontalAlignment.leading, computeValue: { d in
                    d[HorizontalAlignment.leading]
                })
                    
                }
                
                VStack(alignment: .center) {
                    // region, subregion, capital
                    locationInfoView() // TODO: Thicken/bold sub-text for this view only
                    // TODO: Also set so each text view is the same size
                }
                .padding(.top, 32)
                VStack(alignment: .center) {
                    HStack(alignment: .center, spacing: 16.0) {
                        timezoneView()
                        populationView()
                    }
                    HStack(alignment: .center, spacing: 16.0) {
                        
                        languagesView()
                        currenciesView()
                        
                    }
                    HStack(alignment: .center, spacing: 16.0) {
                        
                        carDriverSideView()
                        coatOfArmsView()
                        
                    }
                }
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width)
        }
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
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/4.0)
            .padding(.leading, 0.0)
            .padding(.trailing, 0.0)
    }
    
    @ViewBuilder func countryNameView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(Color.white)
                .shadow(color: Color.gray, radius: 3, x:0, y:2)
            VStack(alignment: .center) {
                Text(viewModel.countryDetails.commonName())
                    .font(countryDetailCommonNameFont())
                    .foregroundStyle(blackColorCountryDetailsCommonName())
                    .layoutPriority(1.0)
                Text(viewModel.countryDetails.officialName())
                    .scaledToFit()
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .font(countryDetailGenericInfoFont())
                    .foregroundStyle(grayColorCountryDetailsOfficalName())
            }
            .padding(.leading, 16.0)
            .padding(.trailing, 16.0)
            .padding(.top, 8.0)
            .padding(.bottom, 8.0)
        }
        .padding(.leading, 16.0)
    }
    
    @ViewBuilder func locationInfoView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(Color.white)
                .shadow(color: Color.gray, radius: 3, x:0, y:2)
            HStack {
                // Region
                regionView()
                    .frame(minWidth: 0, maxWidth: .infinity)
                // Break
                Divider()
                    .frame(width: 2)
                // Subregion
                subRegionView()
                    .frame(minWidth: 0, maxWidth: .infinity)
                // Break
                Divider()
                    .frame(width: 2)
                // Capital
                capitalView()
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .padding(.leading, 16.0)
            .padding(.trailing, 16.0)
            .padding(.top, 16.0)
            .padding(.bottom, 16.0)
            
        }
        .padding(.leading, 16.0)
        .padding(.bottom, 16.0)
    }
    
    @ViewBuilder func capitalView() -> some View {
        shrinkingTextView(string1: "Capital", string2: viewModel.countryDetails.firstCapital())
    }
    
    @ViewBuilder func regionView() -> some View {
        shrinkingTextView(string1: "Region", string2: viewModel.countryDetails.areaRegion())
    }
    
    @ViewBuilder func subRegionView() -> some View {
        shrinkingTextView(string1: "Subregion", string2: viewModel.countryDetails.areaSubregion())
    }
    
    @ViewBuilder func languagesView() -> some View {
        bubbledTextView(string1: "Language(s)", string2: viewModel.listLanguages())
    }
    
    @ViewBuilder func currenciesView() -> some View {
        bubbledTextView(string1: "Currencies", string2: viewModel.listCurrency())
    }
    
    @ViewBuilder func populationView() -> some View {
        bubbledTextView(string1: "Population", string2: viewModel.countryDetails.populationString())
    }
    
    @ViewBuilder func carDriverSideView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(Color.white)
                .shadow(color: Color.gray, radius: 3, x:0, y:2)
            VStack(alignment: .leading, spacing: 0.0) {
                Text("Car Driver Side")
                    .font(countryDetailGenericTitleFont())
                    .foregroundStyle(grayColorCountryDetailsTitle())
                Spacer()
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
                Spacer()
            }
            .padding(.trailing, 8.0)
            .padding(.leading, 8.0)
            .padding(.top, 16.0)
            .padding(.bottom, 16.0)
            
        }
        .padding(.trailing, 16.0)
        .padding(.leading, 16.0)
        .padding(.top, 16.0)
        .padding(.bottom, 16.0)
    }
    
    @ViewBuilder func timezoneView() -> some View {
        bubbledTextView(string1: "Timezone(s)", string2: viewModel.listTimezones())
    }
    
    @ViewBuilder func shrinkingTextView(string1: String, string2: String) -> some View {
        VStack(alignment: .center, spacing: 0.0) {
            Text(string1)
                .lineLimit(1)
                .font(countryDetailGenericTitleFont())
                .foregroundStyle(grayColorCountryDetailsTitle())
            Text(string2)
                .scaledToFit()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .font(countryDetailGenericInfoFont())
                .foregroundStyle(grayColorCountryDetailsInfo())
        }
    }

    @ViewBuilder func genericTextView(string1: String, string2: String) -> some View {
        VStack(alignment: .center, spacing: 0.0) {
            Text(string1)
                .font(countryDetailGenericTitleFont())
                .foregroundStyle(grayColorCountryDetailsTitle())
            Text(string2)
                .font(countryDetailGenericInfoFont())
                .foregroundStyle(grayColorCountryDetailsInfo())
        }
    }
    
    @ViewBuilder func bubbleTextView(string1: String, string2: String) -> some View {
        VStack(alignment: .center, spacing: 0.0) {
            Text(string1)
                .font(countryDetailGenericTitleFont())
                .foregroundStyle(grayColorCountryDetailsTitle())
            Spacer()
            Text(string2)
                .font(countryDetailGenericInfoFont())
                .foregroundStyle(grayColorCountryDetailsInfo())
            Spacer()
        }
    }
    
    @ViewBuilder func bubbledTextView(string1: String, string2: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(Color.white)
                .shadow(color: Color.gray, radius: 3, x:0, y:2)
            bubbleTextView(string1: string1, string2: string2)
                .padding(.trailing, 16.0)
                .padding(.leading, 16.0)
                .padding(.top, 16.0)
                .padding(.bottom, 16.0)
        }
        .padding(.trailing, 16.0)
        .padding(.leading, 16.0)
        .padding(.top, 16.0)
        .padding(.bottom, 16.0)
    }
    
    // Coat of Arms
    @ViewBuilder func coatOfArmsView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(Color.white)
                .shadow(color: Color.gray, radius: 3, x:0, y:2)
            VStack(alignment: .center, spacing: 0) {
                Text("Coat of Arms")
                    .font(countryDetailGenericTitleFont())
                    .foregroundStyle(grayColorCountryDetailsTitle())
                Spacer()
                Image(uiImage: UIImage(data: (viewModel.countryDetails.coatOfArms?.pngData ?? Data())!) ?? UIColor.gray.image())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width/8.0, height: UIScreen.main.bounds.width/6.0)
                    .padding(.trailing, 0.0)
                Spacer()
            }
            .padding(.trailing, 16.0)
            .padding(.leading, 16.0)
            .padding(.top, 16.0)
            .padding(.bottom, 16.0)
        }
        .padding(.trailing, 16.0)
        .padding(.leading, 16.0)
        .padding(.top, 16.0)
        .padding(.bottom, 16.0)
    }
    
    
}

#Preview {
    CountryDetailView(viewModel: MockCountryDetailViewModel(country: mock_countryDetailModel_4, countriesFetcher: CountriesAPIManager(), bookmarkManager: BookmarkManager(), countryTabViewModel: CountryDetailTabViewModel(country: mock_countryDetailModel_4, bookmarkManager: BookmarkManager())))
}
