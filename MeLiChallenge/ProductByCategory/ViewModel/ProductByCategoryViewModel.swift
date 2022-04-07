//
//  ProductByCategoryViewModel.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 29/03/22.
//

import Foundation
import Combine
import Network

class ProductByCategoryViewModel: ObservableObject {
    // MARK: - Properties class
    @Published var results: [Results] = [Results]()
    @Published var shouldShowFuntionalityError: Bool = false
    @Published var isLoading: Bool = true
    @Published var shouldShowNetworkError: Bool = false
    
    private let networkingService: NetworkingServicesProtocol
    
    // MARK: - init
    init(networkingService: NetworkingServicesProtocol = NetworkingService()) {
        self.networkingService = networkingService
    }
    
    // MARK: - Functions
    func getProductsByCategory(categoryId: String) {
        NetworkMonitor.shared.delegate = self
        NetworkMonitor.shared.start()
        guard NetworkMonitor.shared.isNetworkAvailable() else { return }
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
        for item in 0...5 {
            let result = Results.getModelResultBasic("\(item)")
            self.results.append(result)
        }
    }
}

// MARK: - Extension NetworkMonitorDelegats
extension ProductByCategoryViewModel: NetworkMonitorDelegate {
    func networkMonitor(didChangeStatus status: NWPath.Status) {
        if status != .satisfied {
            shouldShowNetworkError = true
        } else {
            shouldShowNetworkError = false
        }
    }
}
