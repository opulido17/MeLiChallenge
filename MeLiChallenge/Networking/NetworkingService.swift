//
//  NetworkingService.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 28/03/22.
//

import Foundation
import Alamofire

final class NetworkingService: NetworkingServicesProtocol {
    func getCategories(completion: @escaping (NetworkingResult<[CategoryModel], String>) -> Void) {
        let url: String = Constants.serv_url_base + Constants.serv_getCategory
        AF.request(url, method: .get).validate(statusCode: Constants.serviceStatusCodeOk).responseDecodable(of: [CategoryModel].self) { response in
            if let categoryModel = response.value {
                completion(.success(categoryModel))
            } else {
                completion(.failure(response.error?.localizedDescription ?? "Error de servicio"))
            }
        }
    }
    
    func getProductsCategory(categoryId: String, completion: @escaping (NetworkingResult<[Results], String>) -> Void) {
        let url: String = Constants.serv_url_base + Constants.serv_getProductsByCategory
        let urlReplace = url.replacingOccurrences(of: "{categoryId}", with: categoryId)
        AF.request(urlReplace, method: .get).validate(statusCode: Constants.serviceStatusCodeOk).responseDecodable(of: SearchResult.self) { response in
            if let result = response.value?.results {
                completion(.success(result))
            } else {
                completion(.failure(response.error?.localizedDescription ?? "Error de servicios"))
            }
        }
    }
    
    func getProdcutsSearchBar(searchText: String, limit: Int, completion: @escaping (NetworkingResult<[Results], String>) -> Void) {
        let url = Constants.serv_url_base + Constants.serv_getProductSearch
        let searchReplace = url.replacingOccurrences(of: "{search}", with: searchText)
        let limitReplace = searchReplace.replacingOccurrences(of: "{limit}", with: "\(limit)")
        let urlRequest = limitReplace.replacingOccurrences(of: " ", with: "%20") // todo : - No deberia ser de esta forma -> Pendiente
        AF.request(urlRequest, method: .get).validate(statusCode: Constants.serviceStatusCodeOk).responseDecodable(of: SearchResult.self) { response in
            if let searchResult = response.value {
                if searchResult.results?.isEmpty ?? false {
                    completion(.failure("Empty List"))
                } else {
                    completion(.success(searchResult.results ?? [Results]()))
                }
            } else {
                completion(.failure(response.error?.localizedDescription ?? "Error de servicio"))
            }
        }
    }
    
    func getProductDescription(itemId: String, completion: @escaping (NetworkingResult<DescriptionModel, String>) -> Void) {
        let url: String = Constants.serv_url_base + Constants.serv_getDescription
        let urlReplace = url.replacingOccurrences(of: "{itemId}", with: "\(itemId)")
        AF.request(urlReplace, method: .get).validate(statusCode: Constants.serviceStatusCodeOk).responseDecodable(of: DescriptionModel.self) { response in
            if let descriptionModel = response.value {
                completion(.success(descriptionModel))
            } else {
                completion(.failure(response.error?.localizedDescription ?? "Error de servicio"))
            }
        }
    }
    
    func getInfoSellerId(sellerId: Int, completion: @escaping (NetworkingResult<SellerModel, String>) -> Void) {
        let url: String = Constants.serv_url_base + Constants.serv_getSellerInfo
        let urlReplace = url.replacingOccurrences(of: "{sellerId}", with: "\(sellerId)")
        AF.request(urlReplace, method: .get).validate(statusCode: Constants.serviceStatusCodeOk).responseDecodable(of: SellerModel.self) { response in
            if let sellerModel = response.value {
                completion(.success(sellerModel))
            } else {
                completion(.failure(response.error?.localizedDescription ?? "Error de servicio"))
            }
        }
    }
    
}
