//
//  HomeViewModel.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 28/03/22.
//

import Foundation
import Combine
import SwiftUI
import Network

class HomeViewModel: ObservableObject {
    // MARK: - Properties class
    @Published var categoryList: [CategoryModel] = [CategoryModel]()
    @Published var shouldShowFuntionalityError: Bool = false
    @Published var isLoading: Bool = true
    @Published var shouldShowNetworkError: Bool = false
    
    private let networkingService: NetworkingServicesProtocol

    // MARK: - init
    init(networkingService: NetworkingServicesProtocol = NetworkingService()) {
        self.networkingService = networkingService
    }
    
    // MARK: - Funtions
    func getCategories() {
        NetworkMonitor.shared.delegate = self
        NetworkMonitor.shared.start()
        guard NetworkMonitor.shared.isNetworkAvailable() else { return }
        getCateriesForShimmer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.networkingService.getCategories { [weak self] result in
                switch result {
                case .success(let categories):
                    self?.isLoading = false
                    self?.categoryList = categories
                case .failure(_):
                    self?.categoryList.removeAll()
                    self?.shouldShowFuntionalityError = true
                }
            }
        }
    }
    
    func getCateriesForShimmer() {
        shouldShowFuntionalityError = false
        for item in 0...7 {
            self.categoryList.append(CategoryModel.getModelCategoryBasic(id: "\(item)"))
        }
    }
}

// MARK: - Extension NetworkMonitorDelegats
extension HomeViewModel: NetworkMonitorDelegate {
    func networkMonitor(didChangeStatus status: NWPath.Status) {
        if status != .satisfied {
            shouldShowNetworkError = true
        } else if categoryList.isEmpty {
            shouldShowNetworkError = false
            getCategories()
        }
    }
}
