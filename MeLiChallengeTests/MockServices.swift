//
//  MockServices.swift
//  MeLiChallengeTests
//
//  Created by Orlando Pulido Marenco on 3/04/22.
//

import Foundation
@testable import MeLiChallenge

final class MockServices: NetworkingServicesProtocol {
    
    var isResultSuccessfully: Bool = true
    
    private let descriptionModel = DescriptionModel(plainText: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
    
    private let sellerModel = SellerModel(seller: SellerItem(id: 0, nickname: "", sellerReputation: SellerItem.Reputation(metrics: SellerItem.Metrics(sales: SellerItem.Sales(completed: 0)))), results: [Results(id: "", siteId: "", title: "", seller: nil, price: 0, prices: nil, salePrice: 0, currencyId: "", availableQuantity: 0, soldQuantity: 0, buyingMode: "", listingTypeId: "", stopTime: "", condition: "", permalink: "", thumbnail: "", acceptsMercadopago: false, installments: nil, attributes: nil, originalPrice: 0, categoryId: "")])
    
    private let resultModel = [Results(id: "", siteId: "", title: "", seller: nil, price: 0, prices: nil, salePrice: 0, currencyId: "", availableQuantity: 0, soldQuantity: 0, buyingMode: "", listingTypeId: "", stopTime: "", condition: "", permalink: "", thumbnail: "", acceptsMercadopago: false, installments: nil, attributes: nil, originalPrice: 0, categoryId: "")]
    
    private let categoriesModel = [CategoryModel(id: "1", name: ""), CategoryModel(id: "2", name: ""), CategoryModel(id: "3", name: "")]
    
    func getCategories(completion: @escaping (NetworkingResult<[CategoryModel], String>) -> Void) {
        if isResultSuccessfully {
            completion(.success(categoriesModel))
        } else {
            completion(.failure("didn't get categories"))
        }
    }
    
    func getProductsCategory(categoryId: String, completion: @escaping (NetworkingResult<[Results], String>) -> Void) {
        if isResultSuccessfully {
            completion(.success(resultModel))
        } else {
            completion(.failure("didn't get product category"))
        }
    }
    
    func getProdcutsSearchBar(searchText: String, limit: Int, completion: @escaping (NetworkingResult<[Results], String>) -> Void) {
        if isResultSuccessfully {
            completion(.success(resultModel))
        } else {
            completion(.failure("didn't get product search bar"))
        }
    }
    
    func getProductDescription(itemId: String, completion: @escaping (NetworkingResult<DescriptionModel, String>) -> Void) {
        if isResultSuccessfully {
            completion(.success(descriptionModel))
        } else {
            completion(.failure("didn't get product description"))
        }
    }
    
    func getInfoSellerId(sellerId: Int, completion: @escaping (NetworkingResult<SellerModel, String>) -> Void) {
        if isResultSuccessfully {
            completion(.success(sellerModel))
        } else {
            completion(.failure("didn't get get info sellerId"))
        }
    }
}
