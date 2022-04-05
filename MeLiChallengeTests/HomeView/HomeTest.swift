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
        let controlExpectation: XCTestExpectation = expectation(description: "Expectation get category successfully")
        viewModel.getCategories()
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertEqual(viewModel.categoryList.count, 8)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            controlExpectation.fulfill()
        }
        wait(for: [controlExpectation], timeout: 2)
        XCTAssertEqual(viewModel.categoryList.count, 3)
    }
    
    func test_GetCategoryTryAgainSuccessfully() {
        test_GetCategoryFailure()
        
        let expectationSuccessfully: XCTestExpectation = expectation(description: "Expectation Successfully try again")
        mockService.isResultSuccessfully = true
        viewModel.getCategories()
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertEqual(viewModel.categoryList.count, 8)
        XCTAssertFalse(viewModel.shouldShowFuntionalityError)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectationSuccessfully.fulfill()
        }
        wait(for: [expectationSuccessfully], timeout: 2)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.shouldShowFuntionalityError)
        XCTAssertEqual(viewModel.categoryList.count, 3)
    }
    
    func test_GetCategoryFailure() {
        let controlExpectation: XCTestExpectation = expectation(description: "Expectation get category failure")
        mockService.isResultSuccessfully = false
        viewModel.getCategories()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            controlExpectation.fulfill()
        }
        wait(for: [controlExpectation], timeout: 2)
        XCTAssertTrue(viewModel.shouldShowFuntionalityError)
        XCTAssertEqual(viewModel.categoryList.count, 0)
    }
}
