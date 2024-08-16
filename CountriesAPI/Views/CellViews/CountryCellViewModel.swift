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
    var showBookmark: Bool { get set }
    init(country: CountryDetailModel, countriesFetcher: CountriesFetchable, bookmarkManager: any BookmarkManagerInterface, showBookmark: Bool)
    func downloadFlag(_ sourceModel: ImageSourceModel)
    func displayBookmark() -> Bool
}

class CountryCellViewModel {
    @Published var country: CountryDetailModel
    @Published var bookmarkManager: any BookmarkManagerInterface
    @Published var showBookmark: Bool
    private let countriesFetcher: CountriesFetchable
    private var disposables = Set<AnyCancellable>()
    
    required init(country: CountryDetailModel, countriesFetcher: CountriesFetchable, bookmarkManager: any BookmarkManagerInterface, showBookmark: Bool) {
        self.countriesFetcher = countriesFetcher
        self.country = country
        self.bookmarkManager = bookmarkManager
        self.showBookmark = showBookmark
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
    
    func displayBookmark() -> Bool {
        return bookmarkManager.contains(officalName: country.officialName())
    }
}
