//
//  ProductHomeModel.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 20/03/22.
//

import Foundation

struct SearchResult: Decodable {
    let siteId: String
    let query: String?
    let paging: Paging?
    var results: [Results]?
    
    private enum CodingKeys: String, CodingKey {
        case siteId = "site_id"
        case query
        case paging
        case results
    }
}

struct Paging: Decodable {
    let total: Int
    let offset: Int
    let limit: Int
    let primaryResults: Int
    
    private enum CodingKeys: String, CodingKey {
        case total
        case offset
        case limit
        case primaryResults = "primary_results"
    }
}

struct Results: Decodable {
    let id: String?
    let siteId: String?
    let title: String?
    let seller: Seller?
    let price: Float
    let prices: Prices?
    let salePrice: Float?
    let currencyId: String?
    var availableQuantity: Int?
    let soldQuantity: Int?
    let buyingMode: String?
    let listingTypeId: String?
    let stopTime: String?
    let condition: String?
    let permalink: String?
    let thumbnail: String?
    let acceptsMercadopago: Bool?
    let installments: Installments?
    let attributes: [Attributes]?
    let originalPrice: Float?
    let categoryId: String?
    var shimmer: Bool? = true

    private enum CodingKeys: String, CodingKey {
        case id
        case siteId = "site_id"
        case title
        case seller
        case price
        case prices
        case salePrice = "sale_price"
        case currencyId = "currency_id"
        case availableQuantity = "available_quantity"
        case soldQuantity = "sold_quantity"
        case buyingMode = "buying_mode"
        case listingTypeId = "listing_type_id"
        case stopTime = "stop_time"
        case condition
        case permalink
        case thumbnail
        case acceptsMercadopago = "accepts_mercadopago"
        case installments
        case attributes
        case originalPrice = "original_price"
        case categoryId = "category_id"
        case shimmer
    }
    
    static func getModelResultBasic(_ id: String = "", _ showShimmer: Bool = false) -> Results {
        return Results(id: id, siteId: "", title: "", seller: nil, price: 0, prices: nil, salePrice: 0, currencyId: "", availableQuantity: 0, soldQuantity: 0, buyingMode: "", listingTypeId: "", stopTime: "", condition: "", permalink: "", thumbnail: "", acceptsMercadopago: false, installments: nil, attributes: nil, originalPrice: 0, categoryId: "", shimmer: showShimmer)
    }
}

struct Seller: Decodable {
    let id: Int
    let carDealer: Bool
    let realEstateAgency: Bool

    private enum CodingKeys: String, CodingKey {
        case id
        case carDealer = "car_dealer"
        case realEstateAgency = "real_estate_agency"
    }
}

struct Prices: Decodable {
    let id: String
    let prices: [SubPrices]?
}

struct SubPrices: Decodable {
    let id: String
    let type: String?
    let amount: Float?
    let regularAmount: Float?
    let metadata: Metadata?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case amount
        case regularAmount = "regular_amount"
        case metadata
    }
}

struct Metadata: Decodable {
    let discountMeliAmount: Float?
    let campaignDiscountPercentage: Float?
    
    private enum CodingKeys: String, CodingKey {
        case discountMeliAmount = "discount_meli_amount"
        case campaignDiscountPercentage = "campaign_discount_percentage"
    }
}

struct Installments: Decodable {
    let quantity: Int
    let amount: Float
    let rate: Float
    let currencyId: String
    
    private enum CodingKeys: String, CodingKey {
        case quantity
        case amount
        case rate
        case currencyId = "currency_id"
    }
}

struct Attributes: Decodable {
    let name: String?
    let valueId: String?
    let valueName: String?
    let attributeGroupId: String?
    let attributeGroupName: String?
    let source: Int?
    let id: String?

    private enum CodingKeys: String, CodingKey {
        case name
        case valueId = "value_id"
        case valueName = "value_name"
        case attributeGroupId = "attribute_group_id"
        case attributeGroupName = "attribute_group_name"
        case source
        case id
    }
}
