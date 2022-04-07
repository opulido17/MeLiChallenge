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
    var categoryId: String = "MCO1747"
    var searchText: String = "iphone"
    var productId: String = "MCO464124554"
    var sellerId: Int = 152737872
    
    private let descriptionModel = DescriptionModel(plainText: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
    
    private let sellerModel = SellerModel(seller: SellerItem(id: 152737872, nickname: "ESTRENAR COLOMBIA", sellerReputation: SellerItem.Reputation(metrics: SellerItem.Metrics(sales: SellerItem.Sales(completed: 8537)))), results: [Results(id: "MCO464124554", siteId: "MCO", title: "Combo 2 Forros Protector Sillas Carro Auto Mascota Perro", seller: Seller(id: 152737872, carDealer: false, realEstateAgency: false), price: 56900, prices: Prices(id: "MCO464124554", prices: nil), salePrice: nil, currencyId: "COP", availableQuantity: 500, soldQuantity: 500, buyingMode: "buy_it_now", listingTypeId: "gold_special", stopTime: "2040-10-22T15:30:20.000Z", condition: "new", permalink: "https://articulo.mercadolibre.com.co/MCO-464124554-combo-2-forros-protector-sillas-carro-auto-mascota-perro-_JM", thumbnail: "http://http2.mlstatic.com/D_646062-MCO43036011644_082020-I.jpg", acceptsMercadopago: true, installments: Installments(quantity: 36, amount: 1580.56, rate: 0, currencyId: "COP"), attributes: [Attributes(name: "Marca", valueId: nil, valueName: "VELBROS", attributeGroupId: "OTHERS", attributeGroupName: "Otros", source: 3376461333454861, id: "BRAND")], originalPrice: nil, categoryId: "MCO178000")])
    
    private let resultModel = [Results(id: "MCO464124554", siteId: "MCO", title: "Combo 2 Forros Protector Sillas Carro Auto Mascota Perro", seller: Seller(id: 152737872, carDealer: false, realEstateAgency: false), price: 56900, prices: Prices(id: "MCO464124554", prices: nil), salePrice: nil, currencyId: "COP", availableQuantity: 500, soldQuantity: 500, buyingMode: "buy_it_now", listingTypeId: "gold_special", stopTime: "2040-10-22T15:30:20.000Z", condition: "new", permalink: "https://articulo.mercadolibre.com.co/MCO-464124554-combo-2-forros-protector-sillas-carro-auto-mascota-perro-_JM", thumbnail: "http://http2.mlstatic.com/D_646062-MCO43036011644_082020-I.jpg", acceptsMercadopago: true, installments: Installments(quantity: 36, amount: 1580.56, rate: 0, currencyId: "COP"), attributes: [Attributes(name: "Marca", valueId: nil, valueName: "VELBROS", attributeGroupId: "OTHERS", attributeGroupName: "Otros", source: 3376461333454861, id: "BRAND")], originalPrice: nil, categoryId: "MCO178000")]
    
    private let categoriesModel = [CategoryModel(id: "MCO1747", name: "Accesorios para Vehículos"), CategoryModel(id: "MCO441917", name: "Agro"), CategoryModel(id: "MCO1403", name: "Alimentos y Bebidas")]
    
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
