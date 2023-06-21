//
//  KedaTech_ProjectTests.swift
//  KedaTech ProjectTests
//
//  Created by Ricky Austin on 20/06/23.
//

import XCTest
@testable import KedaTech_Project

final class KedaTech_ProjectTests: XCTestCase {
    var viewModel: HomeViewModel!

    override func setUpWithError() throws {
        viewModel = HomeViewModel()
        let mockItems = viewModel.generateModel()
        viewModel.items = mockItems
        viewModel.baseItems = mockItems
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testSuccessSearch() throws {
        viewModel.searchText = "Car"
        viewModel.filterSearch()
        XCTAssertFalse(viewModel.items.isEmpty)
    }
    
    func testFailSearch() throws {
        viewModel.searchText = "Caracas"
        viewModel.filterSearch()
        XCTAssertTrue(viewModel.items.isEmpty)
    }
    
    func testSuccessFilterFavourite() throws {
        let midIndex = viewModel.items.count/2
        viewModel.baseItems[midIndex].isFavourite = true
        viewModel.isFavourite = true
        viewModel.filterFavourite()
        XCTAssertNotNil(viewModel.items.first)
    }
    
    func testFailFilterFavourite() throws {
        viewModel.isFavourite = true
        viewModel.filterFavourite()
        XCTAssertNil(viewModel.items.first)
    }

}
