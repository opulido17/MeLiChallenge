//
//  HomeTest.swift
//  MeLiChallengeTests
//
//  Created by Orlando Pulido Marenco on 3/04/22.
//

import XCTest
@testable import MeLiChallenge

class HomeTest: XCTestCase {
    
    var viewModel: HomeViewModel!
    var mockService: MockServices!
    
    override func setUp() {
        super.setUp()
        mockService = MockServices()
        viewModel = .init(networkingService: mockService)
    }
    
    func test_LoadShimmerGetCategorySuccessfully() {
        viewModel.getCategories()
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertEqual(viewModel.categoryList.count, 8)
    }
    
    func test_GetCategorySuccessfully() {
        let controlExpectation: XCTestExpectation = expectation(description: "control expectation")
        viewModel.getCategories()
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertEqual(viewModel.categoryList.count, 8)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            controlExpectation.fulfill()
        }
        wait(for: [controlExpectation], timeout: 2)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.categoryList.count, 3)
    }
    
    func test_GetCategoryFailure() {
        let controlExpectation: XCTestExpectation = expectation(description: "control expectation")
        mockService.isResultSuccessfully = false
        viewModel.getCategories()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            controlExpectation.fulfill()
        }
        wait(for: [controlExpectation], timeout: 2)
        XCTAssertTrue(viewModel.shouldShowFuntionalityError)
    }
}
