//
//  LocationServiceTests.swift
//  CountriesAPITests
//
//  Created by Raymond Gatz on 8/22/24.
//

import CoreLocation
import XCTest
import Foundation
@testable import CountriesAPI

final class LocationServiceTests: XCTestCase {
    
    var locationService: LocationServiceInterface?
    
    override func setUpWithError() throws {
        locationService = MockLocationService()
    }
    
    override func tearDownWithError() throws {
        locationService = nil
    }
    
    func testSomething() throws {
        // Need to create proper mock of location manager that can be injected for replicating location system
    }
}
