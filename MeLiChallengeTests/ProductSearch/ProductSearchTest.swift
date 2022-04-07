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
        viewModel.searchProduct(searchText: mokcService.searchText)
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertEqual(viewModel.searchResult.count, 6)
    }
    
    func test_GetProductSearchSuccessfully() {
        let controlExpectation: XCTestExpectation = expectation(description: "Expectation get product search successfully")
        viewModel.searchProduct(searchText: mokcService.searchText)
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
        let controlExpectation: XCTestExpectation = expectation(description: "Expectation get product search failure")
        mokcService.isResultSuccessfully = false
        viewModel.searchProduct(searchText: mokcService.searchText)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            controlExpectation.fulfill()
        }
        wait(for: [controlExpectation], timeout: 2)
        XCTAssertTrue(viewModel.shouldShowFuntionalityError)
    }
    
    func test_LoadShimmerProductPagingSuccessfully() {
        viewModel.updateSearchProduct(searchText: mokcService.searchText)
        XCTAssertTrue(viewModel.isLoadingReload)
        let shimmer = viewModel.searchResult.last?.shimmer ?? false
        XCTAssertTrue(shimmer)
        XCTAssertEqual(viewModel.searchResult.count, 1)
    }
    
    func test_UpdateProductPagingSuccessfully() {
        let controlExpectation: XCTestExpectation = expectation(description: "Expectation update product paging successfully")
        viewModel.updateSearchProduct(searchText: mokcService.searchText)
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
        let controlExpectation: XCTestExpectation = expectation(description: "Expectation update product paging failure")
        mokcService.isResultSuccessfully = false
        viewModel.updateSearchProduct(searchText: mokcService.searchText)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
            controlExpectation.fulfill()
        }
        wait(for: [controlExpectation], timeout: 2)
        XCTAssertTrue(viewModel.shouldShowFuntionalityReloadError)
    }
    
    func test_GetProductSearchWithPagingActionSuccessfully() {
        test_GetProductSearchSuccessfully()
        let expectationPaging: XCTestExpectation = expectation(description: "Expectation update product paging successfully")
        viewModel.updateSearchProduct(searchText: mokcService.searchText)
        XCTAssertEqual(viewModel.limit, 20)
        XCTAssertTrue(viewModel.isLoadingReload)
        XCTAssertEqual(viewModel.searchResult.count, 2)
        let shimmer = viewModel.searchResult.last?.shimmer ?? false
        XCTAssertTrue(shimmer)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
            expectationPaging.fulfill()
        }
        wait(for: [expectationPaging], timeout: 2)
        XCTAssertFalse(viewModel.isLoadingReload)
        XCTAssertEqual(viewModel.searchResult.count, 1)
    }
    
    func test_GetProductSearchWithPagingActionFailure() {
        test_GetProductSearchSuccessfully()
        let expectationPaging: XCTestExpectation = expectation(description: "Expectation update product paging Failure")
        mokcService.isResultSuccessfully = false
        viewModel.updateSearchProduct(searchText: mokcService.searchText)
        XCTAssertEqual(viewModel.limit, 20)
        XCTAssertTrue(viewModel.isLoadingReload)
        XCTAssertEqual(viewModel.searchResult.count, 2)
        let shimmer = viewModel.searchResult.last?.shimmer ?? false
        XCTAssertTrue(shimmer)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
            expectationPaging.fulfill()
        }
        wait(for: [expectationPaging], timeout: 2)
        XCTAssertEqual(viewModel.searchResult.count, 1)
        XCTAssertEqual(viewModel.limit, 10)
        XCTAssertTrue(viewModel.shouldShowFuntionalityReloadError)
    }
}
