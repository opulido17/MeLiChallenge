//
//  HomeViewModel.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 28/03/22.
//

import Foundation
import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var categoryList: [CategoryModel] = [CategoryModel]()
    @Published var shouldShowFuntionalityError: Bool = false
    @Published var isLoading: Bool = true
    
    private let networkingService: NetworkingServicesProtocol

    init(networkingService: NetworkingServicesProtocol = NetworkingService()) {
        self.networkingService = networkingService
    }
    
    func getCategories() {
        getCateriesForShimmer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.networkingService.getCategories { [weak self] result in
                switch result {
                case .success(let categories):
                    self?.isLoading = false
                    self?.categoryList = categories
                case .failure(_):
                    self?.shouldShowFuntionalityError = true
                }
            }
        }
    }
    
    func getCateriesForShimmer() {
        for _ in 0...7 {
            self.categoryList.append(CategoryModel.getModelCategoryBasic())
        }
    }
}
