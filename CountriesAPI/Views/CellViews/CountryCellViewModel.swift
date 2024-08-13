//
//  CountryCellViewModel.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/12/24.
//

import Foundation
import Combine

protocol CountryCellViewModelInterface: ObservableObject {
    var country: CountryDetailModel { get set }
    init(country: CountryDetailModel, countriesFetcher: CountriesFetchable)
    func downloadFlag(_ sourceModel: ImageSourceModel)
}

class CountryCellViewModel {
    @Published var country: CountryDetailModel
    private let countriesFetcher: CountriesFetchable
    private var disposables = Set<AnyCancellable>()
    
    required init(country: CountryDetailModel, countriesFetcher: CountriesFetchable) {
        self.countriesFetcher = countriesFetcher
        self.country = country
    }
}

extension CountryCellViewModel: CountryCellViewModelInterface {
    
    func downloadFlag(_ sourceModel: ImageSourceModel) {
        countriesFetcher
            .downloadImage(sourceModel)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                switch value {
                case .failure:
                    self?.country.flags?.pngData = nil
                case .finished:
                    break
                }
            } receiveValue: { [weak self] imageData in
                self?.country.flags?.pngData = imageData
            }
            .store(in: &disposables)
    }
}
