//
//  ProductByCategoryView.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 29/03/22.
//

import SwiftUI

struct ProductByCategoryView: View {
    
    @Environment(\.presentationMode) var goToBack
    @ObservedObject var viewModel = ProductByCategoryViewModel()
    var categoryId: String
    var categoryName: String
    let colums: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: colums, spacing: 15) {
                if !viewModel.results.isEmpty {
                    ForEach(self.viewModel.results, id: \.id) { result in
                        NavigationLink(destination: ProductDetailView(goBack: _goToBack, viewModel: ProductDetailViewModel(), model: result)) {
                            OtherProductsViewCell(model: result, isLoading: viewModel.isLoading, cellFrame: (width: cardWidth(), height: 270))
                        }
                    }
                } else {
//                    viewModel.getProductByCategoryForShimmer()
//                    OtherProductsViewCell(model: viewModel, isLoading: viewModel.isLoading, cellFrame: (width: cardWidth(), height: 270))
////                    ForEach(0...9, id: \.self) { _ in
////                        let result = Results.getModelResultBasic("")
////                        OtherProductsViewCell(model: result, isLoading: viewModel.isLoading, cellFrame: (width: cardWidth(), height: 270))
////                    }
                }
            }
            .padding(.horizontal, 5)
            .padding(.bottom, 10)
            .navigationTitle(categoryName)
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.getProductsByCategory(categoryId: categoryId)
        }
        .popup(isPresented: $viewModel.shouldShowFuntionalityError) {
            ErrorAlertView(isPresented: $viewModel.shouldShowFuntionalityError, text: Constants.messageErrorGeneric, image: Image("errorServiceGeneral"), confirm: {
                viewModel.shouldShowFuntionalityError = false
                goToBack.wrappedValue.dismiss()
            })
        }
    }
    
    // MARK: - Fuctions
    private func cardWidth() -> CGFloat {
        return (UIScreen.main.bounds.width / 2) - 15
    }
}

struct ProductByCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        ProductByCategoryView(categoryId: "", categoryName: "")
    }
}
