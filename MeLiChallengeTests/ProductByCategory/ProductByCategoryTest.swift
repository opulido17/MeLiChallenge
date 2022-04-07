//
//  ProductByCategoryTest.swift
//  MeLiChallengeTests
//
//  Created by Orlando Pulido Marenco on 3/04/22.
//

import XCTest
@testable import MeLiChallenge

class ProductByCategoryTest: XCTestCase {

    var viewModel: ProductByCategoryViewModel!
    var mockService: MockServices!
    
    override func setUp() {
        super.setUp()
        mockService = MockServices()
        viewModel = .init(networkingService: mockService)
    }
    
    func test_LoadShimmerProductByCategorySuccessfully() {
        viewModel.getProductsByCategory(categoryId: mockService.categoryId)
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertEqual(viewModel.results.count, 6)
    }
    
    func test_GetProductByCategorySuccessfully() {
        let controlExpectation: XCTestExpectation = expectation(description: "Expectation get product by category successfully")
        viewModel.getProductsByCategory(categoryId: mockService.categoryId)
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertEqual(viewModel.results.count, 6)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            controlExpectation.fulfill()
        }
        wait(for: [controlExpectation], timeout: 2)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.results.count, 1)
    }
    
    func test_GetProductByCategoryFailure() {
        let controlExpectation: XCTestExpectation = expectation(description: "Expectation get product by category failure")
        mockService.isResultSuccessfully = false
        viewModel.getProductsByCategory(categoryId: mockService.categoryId)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            controlExpectation.fulfill()
        }
        wait(for: [controlExpectation], timeout: 2)
        XCTAssertTrue(viewModel.shouldShowFuntionalityError)
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertEqual(viewModel.results.count, 6)
    }
}
