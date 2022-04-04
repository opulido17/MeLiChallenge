//
//  ProductByCategoryViewModel.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 29/03/22.
//

import Foundation
import Combine

class ProductByCategoryViewModel: ObservableObject {
    
    @Published var results: [Results] = [Results]()
    @Published var shouldShowFuntionalityError: Bool = false
    @Published var isLoading: Bool = true
    
    private let networkingService: NetworkingServicesProtocol
    
    init(networkingService: NetworkingServicesProtocol = NetworkingService()) {
        self.networkingService = networkingService
    }
    
    func getProductsByCategory(categoryId: String) {
        getProductByCategoryForShimmer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.networkingService.getProductsCategory(categoryId: categoryId) { [weak self] result in
                switch result {
                case .success(let products):
                    self?.isLoading = false
                    self?.results = products
                case .failure(_):
                    self?.shouldShowFuntionalityError = true
                }
            }
        }
    }
    
    func getProductByCategoryForShimmer() {
        for _ in 0...9 {
            let result = Results.getModelResultBasic("")
            self.results.append(result)
        }
    }
}
