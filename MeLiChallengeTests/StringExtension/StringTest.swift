//
//  StringTest.swift
//  MeLiChallengeTests
//
//  Created by Orlando Pulido Marenco on 4/04/22.
//

import XCTest
@testable import MeLiChallenge

class StringTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func test_ReplaceHttpUrl() {
        let url = "http://http2.mlstatic.com/D_646062-MCO43036011644_082020-I.jpg"
        XCTAssertEqual(url.replaceHttpUrl(), "https://http2.mlstatic.com/D_646062-MCO43036011644_082020-I.jpg")
    }
    
    func test_PriceToNumber() {
        let price = "599999.17"
        XCTAssertEqual(price.toPriceNumber(), "$ 599.999")
    }
    
    func test_ProductState() {
        var condition = "new"
        XCTAssertEqual(condition.productState(), "Nuevo")
        condition = "used"
        XCTAssertEqual(condition.productState(), "Usado")
    }
}

