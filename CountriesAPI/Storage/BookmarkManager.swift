//
//  BookmarkManager.swift
//  CountriesAPI
//
//  Created by Raymond Gatz on 8/15/24.
//

import Foundation

protocol BookmarkManagerInterface: ObservableObject {
    var bookmarkedCountries: [String] { get set }
    func saveOrDeleteEntry(officalName: String)
    func contains(officalName: String) -> Bool
}

class BookmarkManager {
    @Published var bookmarkedCountries: [String]
    private let savedDataName = "SavedCountryNames"
    init() {
        bookmarkedCountries = []
        loadBookmarks()
    }
}

extension BookmarkManager: BookmarkManagerInterface {
    private func loadBookmarks() {
        let defaults = UserDefaults.standard
        bookmarkedCountries = defaults.stringArray(forKey: savedDataName) ?? [String]()
    }
    
    private func saveBookmarks() {
        let defaults = UserDefaults.standard
        defaults.set(bookmarkedCountries, forKey: savedDataName)
    }
    
    func saveOrDeleteEntry(officalName: String) {
        if contains(officalName: officalName) {
            deleteEntry(officalName: officalName)
        } else {
            saveEntry(officalName: officalName)
        }
    }
    
    private func saveEntry(officalName: String) {
        bookmarkedCountries.append(officalName)
        saveBookmarks()
    }
    
    private func deleteEntry(officalName: String) {
        bookmarkedCountries = bookmarkedCountries.filter { country in
            country != officalName
        }
        saveBookmarks()
    }
    
    func contains(officalName: String) -> Bool {
        return bookmarkedCountries.contains { $0 == officalName  }
    }
    
    // this function exists for testing only. There is no use case in the app proper that would require a reset function.
    // no one should be using this in app
    // TODO: Make a Mock Bookmark Manager and let it have this
    func resetBookmarks() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: savedDataName)
    }
    
    
}
