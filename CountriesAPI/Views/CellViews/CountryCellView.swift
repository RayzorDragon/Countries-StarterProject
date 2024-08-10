//
//  CountryCellView.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/10/24.
//

import SwiftUI

struct CountryCellView <Model>: View where Model:CountriesListViewModelInterface {
    
    @StateObject private var viewModel: Model
    var country: CountryListModel
    
    init(viewModel: Model, country: CountryListModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.country = country
    }
    
    var body: some View {
        HStack {
            Image(uiImage: UIImage(data: (viewModel.flagList[country.flagURL()] ?? Data())!) ?? UIColor.gray.image())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width/3.0, height: UIScreen.main.bounds.width/4.0)
                .padding(.trailing, 0.0)
            VStack(alignment: .leading) {
                Text(country.commonName())
                    .font(.headline)
                Text(country.officialName())
                Text(country.firstCapital())
                    .font(.callout)
                    .foregroundStyle(.gray)
            }
            Spacer()
        }
        .onAppear {
            if viewModel.flagList[country.flagURL()] == nil {
                viewModel.downloadFlag(country.flagURL())
            }
        }
    }
}

#Preview {
    CountryCellView(viewModel: MockCountriesListViewModel(countriesFetcher: CountryAPI()), country: mock_countriesListModel_1)
}
