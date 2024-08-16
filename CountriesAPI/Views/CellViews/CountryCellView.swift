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
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(Color.white)
                .shadow(color: Color.gray, radius: 3, x:0, y:2)
            HStack {
                Image(uiImage: UIImage(data: (viewModel.country.flags?.pngData ?? Data())!) ?? UIColor.gray.image())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .border(.gray, width: 1.0)
                    .frame(width: UIScreen.main.bounds.width/3.0, height: UIScreen.main.bounds.width/4.0)
                    .padding(.trailing, 10.0)
                    .padding(.leading, 10.0)
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
            VStack {
                HStack(alignment: .top) {
                    Spacer()
                    if viewModel.showBookmark && viewModel.displayBookmark() {
                        Image(systemName: "bookmark.fill")
                            .padding(.top, 16.0)
                            .padding(.trailing, 16.0)
                    }
                }
                Spacer()
            }
            
        }
        .onAppear {
            if viewModel.country.flags?.pngData == nil {
                viewModel.downloadFlag(viewModel.country.flags ?? ImageSourceModel())
            }
        }
    }
}

#Preview {
    CountryCellView(viewModel: MockCountryCellViewModel(country: mock_countryDetailModel_1, countriesFetcher: CountriesAPIManager(), bookmarkManager: BookmarkManager(), showBookmark: true))
}
