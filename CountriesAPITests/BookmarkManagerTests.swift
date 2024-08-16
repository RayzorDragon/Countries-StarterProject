//
//  BookmarkManagerTests.swift
//  CountriesAPITests
//
//  Created by Raymond Gatz on 8/16/24.
//

import XCTest
import Foundation
@testable import CountriesAPI

final class BookmarkmanagerTests: XCTestCase {
    var bookmarkManager: BookmarkManager?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        bookmarkManager = BookmarkManager()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        bookmarkManager?.resetBookmarks()
        bookmarkManager = nil
    }
    
    func testSaveOrDeleteEntry() throws {
        let expectedValue1 = mock_countryDetailModel_1.officialName()
        let returnedResult1 = bookmarkManager!.bookmarkedCountries.contains { $0 == expectedValue1 }
        // no entry was ever made
        XCTAssertFalse(returnedResult1)
        
        bookmarkManager?.saveOrDeleteEntry(officalName: expectedValue1)
        let returnedResult2 = bookmarkManager!.bookmarkedCountries.contains { $0 == expectedValue1 }
        // new entry was added
        XCTAssertTrue(returnedResult2)
        
        bookmarkManager?.saveOrDeleteEntry(officalName: expectedValue1)
        let returnedResult3 = bookmarkManager!.bookmarkedCountries.contains { $0 == expectedValue1 }
        // new entry was removed
        XCTAssertFalse(returnedResult3)
        
        
    }
    
    func testContains() throws {
        let expectedValue1 = mock_countryDetailModel_1.officialName()
        let returnedResult1 = bookmarkManager!.bookmarkedCountries.contains { $0 == expectedValue1 }
        // no entry was ever made
        XCTAssertFalse(returnedResult1)
        
        bookmarkManager?.saveOrDeleteEntry(officalName: expectedValue1)
        
        let returnedResult2 = bookmarkManager!.contains(officalName: expectedValue1)
        
        // new entry was added
        XCTAssertTrue(returnedResult2)
        
        bookmarkManager?.saveOrDeleteEntry(officalName: expectedValue1)
        let returnedResult3 = bookmarkManager!.contains(officalName: expectedValue1)
        // new entry was removed
        XCTAssertFalse(returnedResult3)
        
        
    }
}
