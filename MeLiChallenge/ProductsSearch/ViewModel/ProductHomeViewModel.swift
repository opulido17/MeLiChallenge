//
//  ProductHomeViewModel.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 20/03/22.
//

import Foundation
import Combine
import SwiftUI

class ProductHomeViewModel: ObservableObject {
    // MARK: - Properties class
    @Published var searchResult: [Results] = [Results]()
    @Published var limit: Int = 10
    @Published var shouldShowFuntionalityError: Bool = false
    @Published var shouldShowFuntionalityReloadError: Bool = false
    @Published var isLoading: Bool = false
    @Published var isLoadingReload: Bool = false
    
    private let networkingService: NetworkingServicesProtocol
    
    // MARK: - init
    init(networkingService: NetworkingServicesProtocol = NetworkingService()) {
        self.networkingService = networkingService
    }
    
    // MARK: - Fuctions
    func searchProduct(searchText: String) {
        resetData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.networkingService.getProdcutsSearchBar(searchText: searchText, limit: self.limit) { [weak self] result in
                switch result {
                case .success(let result):
                    self?.isLoading = false
                    self?.searchResult = result
                case .failure(_):
                    self?.shouldShowFuntionalityError = true
                }
            }
        }
    }
    
    func updateSearchProduct(searchText: String) {
        resetDataReload()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
            self.networkingService.getProdcutsSearchBar(searchText: searchText, limit: self.limit) { [weak self] result in
                switch result {
                case .success(let result):
                    self?.searchResult = result
                    self?.isLoadingReload = false
                case .failure(_):
                    self?.limit -= 10
                    self?.shouldShowFuntionalityReloadError = true
                    self?.searchResult.removeLast()
                }
            }
        }
    }
    
    func removeData() {
        searchResult.removeAll()
    }
    
    private func resetData() {
        limit = 10
        isLoading = true
        shouldShowFuntionalityError = false
        removeData()
        loadDataShimmer()
    }
    
    private func loadDataShimmer() {
        for product in 0...5 {
            self.searchResult.append(Results.getModelResultBasic(String(product)))
        }
    }
    
    private func resetDataReload() {
        loadDataShimmerUpdate()
        isLoadingReload = true
        limit += 10
        shouldShowFuntionalityReloadError = false
    }
    
    func loadDataShimmerUpdate() {
        self.searchResult.append(Results.getModelResultBasic("", true))
    }
}
