//
//  ProductDetailTest.swift
//  MeLiChallengeTests
//
//  Created by Orlando Pulido Marenco on 3/04/22.
//

import XCTest
@testable import MeLiChallenge

class ProductDetailTest: XCTestCase {
    
    var viewModel: ProductDetailViewModel!
    var mockService: MockServices!
    
    override func setUp() {
        super.setUp()
        mockService = MockServices()
        viewModel = .init(networkingService: mockService)
    }
    
    func test_GetDrescriptionSuccessfully() {
        viewModel.getProductDescription(itemId: "")
        XCTAssertFalse(viewModel.isLoadingDescription)
        XCTAssertNotNil(viewModel.descriptionModel)
    }
    
    func test_GetDrescriptionFailure() {
        mockService.isResultSuccessfully = false
        viewModel.getProductDescription(itemId: "")
        XCTAssertTrue(viewModel.shouldShowDescriptionFuntionalityError)
        XCTAssertNil(viewModel.descriptionModel)
    }
    
    func test_GetInfoSellerSuccessfully() {
        viewModel.getInfoSellerId(sellerId: 0)
        XCTAssertFalse(viewModel.isLoadingSeller)
        XCTAssertNotNil(viewModel.sellerModel)
    }
    
    func test_GetInfoSellerFailure() {
        mockService.isResultSuccessfully = false
        viewModel.getInfoSellerId(sellerId: 0)
        XCTAssertTrue(viewModel.shouldShowSellerFuntionalityError)
        XCTAssertNil(viewModel.sellerModel)
    }
}
