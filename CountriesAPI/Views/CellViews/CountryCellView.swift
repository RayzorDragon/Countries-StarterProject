//
//  CountryCellView.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/10/24.
//

import SwiftUI

struct CountryCellView <Model>: View where Model:CountryCellViewModelInterface {
    
    @StateObject private var viewModel: Model
    
    init(viewModel: Model) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        HStack {
            Image(uiImage: UIImage(data: (viewModel.country.flags.pngData ?? Data())!) ?? UIColor.gray.image())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .border(.gray, width: 1.0)
                .frame(width: UIScreen.main.bounds.width/3.0, height: UIScreen.main.bounds.width/4.0)
                .padding(.trailing, 0.0)
            VStack(alignment: .leading) {
                Text(viewModel.country.commonName())
                    .font(countryListNameFont())
                    .foregroundStyle(blackColorCountryListNames())
                Text(viewModel.country.officialName())
                    .font(countryListOfficalFont())
                    .foregroundStyle(blackColorCountryListNames())
                Text(viewModel.country.firstCapital())
                    .font(countryListCapitalFont())
                    .foregroundStyle(grayColorCountryListCapital())
            }
            Spacer()
        }
        .onAppear {
            if viewModel.country.flags.pngData == nil {
                viewModel.downloadFlag(viewModel.country.flags)
            }
        }
    }
}

#Preview {
    CountryCellView(viewModel: MockCountryCellViewModel(country: mock_countryDetailModel_1, countriesFetcher: CountryAPI()))
}
