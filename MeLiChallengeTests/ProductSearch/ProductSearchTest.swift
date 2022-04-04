//
//  ProductSearchTest.swift
//  MeLiChallengeTests
//
//  Created by Orlando Pulido Marenco on 3/04/22.
//

import XCTest
@testable import MeLiChallenge

class ProductSearchTest: XCTestCase {
    
    var viewModel: ProductHomeViewModel!
    var mokcService: MockServices!
    
    override func setUp() {
        super.setUp()
        mokcService = MockServices()
        viewModel = .init(networkingService: mokcService)
    }
    
    func test_LoadShimmerProductSearchSuccessfully() {
        viewModel.searchProduct(searchText: "")
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertEqual(viewModel.searchResult.count, 6)
    }
    
    func test_GetProductSearchSuccessfully() {
        let controlExpectation: XCTestExpectation = expectation(description: "control expectation")
        viewModel.searchProduct(searchText: "")
        XCTAssertEqual(viewModel.limit, 10)
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertEqual(viewModel.searchResult.count, 6)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            controlExpectation.fulfill()
        }
        wait(for: [controlExpectation], timeout: 2)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.searchResult.count, 1)
    }
    
    func test_GetProductSearchFailure() {
        let controlExpectation: XCTestExpectation = expectation(description: "control expectation")
        mokcService.isResultSuccessfully = false
        viewModel.searchProduct(searchText: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            controlExpectation.fulfill()
        }
        wait(for: [controlExpectation], timeout: 2)
        XCTAssertTrue(viewModel.shouldShowFuntionalityError)
    }
    
    func test_LoadShimmerProductPagingSuccessfully() {
        viewModel.updateSearchProduct(searchText: "")
        XCTAssertTrue(viewModel.isLoadingReload)
        XCTAssertEqual(viewModel.searchResult.count, 1)
    }
    
    func test_UpdateProductPagingSuccessfully() {
        let controlExpectation: XCTestExpectation = expectation(description: "control expectation")
        viewModel.updateSearchProduct(searchText: "")
        XCTAssertEqual(viewModel.limit, 20)
        XCTAssertTrue(viewModel.isLoadingReload)
        XCTAssertEqual(viewModel.searchResult.count, 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
            controlExpectation.fulfill()
        }
        wait(for: [controlExpectation], timeout: 2)
        XCTAssertFalse(viewModel.isLoadingReload)
        XCTAssertEqual(viewModel.searchResult.count, 1)
    }
    
    func test_UpdateProductPagingFailure() {
        let controlExpectation: XCTestExpectation = expectation(description: "control expectation")
        mokcService.isResultSuccessfully = false
        viewModel.updateSearchProduct(searchText: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
            controlExpectation.fulfill()
        }
        wait(for: [controlExpectation], timeout: 2)
        XCTAssertTrue(viewModel.shouldShowFuntionalityReloadError)
    }
}
