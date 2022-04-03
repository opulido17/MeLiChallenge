//
//  NetworkingServicesProtocol.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 28/03/22.
//

import Foundation

protocol NetworkingServicesProtocol {
    func getCategories(completion: @escaping (NetworkingResult<[CategoryModel], String>) -> Void)
    func getProductsCategory(categoryId: String, completion: @escaping (NetworkingResult<[Results], String>) -> Void)
    func getProdcutsSearchBar(searchText: String, limit: Int, completion: @escaping (NetworkingResult<[Results], String>) -> Void)
    func getProductDescription(itemId: String, completion: @escaping (NetworkingResult<DescriptionModel, String>) -> Void)
    func getInfoSellerId(sellerId: Int, completion: @escaping (NetworkingResult<SellerModel, String>) -> Void)
}
