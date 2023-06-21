//
//  KedaTech_ProjectUITests.swift
//  KedaTech ProjectUITests
//
//  Created by Ricky Austin on 20/06/23.
//

import XCTest

final class KedaTech_ProjectUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testTapCell() throws {
        app.launch()
        let firstCell =  app.collectionViews.element.cells.firstMatch
        XCTAssertTrue(firstCell.waitForExistence(timeout: 2))
        firstCell.tap()
    }
    
    func testSearch() throws {
        app.launch()
        let searchBar = app.navigationBars.element.searchFields.element
        searchBar.tap()
        searchBar.typeText("Car")
        let firstCell = app.collectionViews.cells.firstMatch
        XCTAssertTrue(firstCell.waitForExistence(timeout: 2))
    }

    func testFilterFavourite() throws {
        app.launch()
        let favButton = app.navigationBars.element.buttons.firstMatch
        XCTAssertTrue(favButton.waitForExistence(timeout: 2))
        favButton.tap()
    }
}
