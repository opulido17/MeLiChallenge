//
//  ProductDetailViewModel.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 22/03/22.
//

import Foundation
import Combine
import SwiftUI

class ProductDetailViewModel: ObservableObject {
    
    @Published var descriptionModel: DescriptionModel?
    @Published var sellerModel: SellerModel?
    @Published var isLoadingDescription: Bool = true
    @Published var isLoadingSeller: Bool = true
    @Published var shouldShowDescriptionFuntionalityError: Bool = false
    @Published var shouldShowSellerFuntionalityError: Bool = false
    
    private let networkingService: NetworkingServicesProtocol
    
    init(networkingService: NetworkingServicesProtocol = NetworkingService(), itemId: String, sellerId: Int) {
        self.networkingService = networkingService
        
        self.getProductDescription(itemId: itemId)
        self.getInfoSellerId(sellerId: sellerId)
    }
    
    func getProductDescription(itemId: String) {
        self.networkingService.getProductDescription(itemId: itemId) { [weak self] result in
            switch result {
            case .success(let descriptionModel):
                self?.descriptionModel = descriptionModel
                self?.isLoadingDescription = false
            case .failure(_):
                self?.shouldShowDescriptionFuntionalityError = true
            }
        }
    }
    
    func getInfoSellerId(sellerId: Int) {
        self.networkingService.getInfoSellerId(sellerId: sellerId) { [weak self] result in
            switch result {
            case .success(let sellerModel):
                self?.sellerModel = sellerModel
                self?.isLoadingSeller = false
            case .failure(_):
                self?.shouldShowSellerFuntionalityError = true
            }
        }
    }
}
