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
    var bookmarkManager: any BookmarkManagerInterface { get set }
    init(country: CountryDetailModel, countriesFetcher: CountriesFetchable, bookmarkManager: any BookmarkManagerInterface)
    func downloadFlag(_ sourceModel: ImageSourceModel)
}

class CountryCellViewModel {
    @Published var country: CountryDetailModel
    @Published var bookmarkManager: any BookmarkManagerInterface
    private let countriesFetcher: CountriesFetchable
    private var disposables = Set<AnyCancellable>()
    
    required init(country: CountryDetailModel, countriesFetcher: CountriesFetchable, bookmarkManager: any BookmarkManagerInterface) {
        self.countriesFetcher = countriesFetcher
        self.country = country
        self.bookmarkManager = bookmarkManager
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
