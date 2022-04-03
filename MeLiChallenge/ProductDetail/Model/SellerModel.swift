//
//  SellerModel.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 22/03/22.
//

import Foundation

struct SellerModel: Decodable{
    let seller : SellerItem?
    let results: [Results]?
}

struct SellerItem: Decodable {
    let id: Int
    let nickname: String
    let sellerReputation: Reputation?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case nickname
        case sellerReputation = "seller_reputation"
    }
    
    struct Reputation: Decodable {
        let metrics: Metrics?
    }
    
    struct Metrics: Decodable {
        let sales: Sales
    }
    
    struct Sales: Decodable {
        let completed: Int
    }
}
