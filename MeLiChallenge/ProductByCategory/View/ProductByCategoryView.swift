//
//  ProductByCategoryView.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 29/03/22.
//

import SwiftUI
import Network

struct ProductByCategoryView: View {
    
    @Environment(\.presentationMode) var goToBack
    @ObservedObject var viewModel = ProductByCategoryViewModel()
    @State private var isPresentedSearchBar: Bool = false
    @State private var isPresentedProductDetail: Bool = false
    @State private var result: Results?
    var categoryId: String
    var categoryName: String
    let colums: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        ScrollView {
            NavigationLink(destination: ProductDetailView(viewModel: ProductDetailViewModel(itemId: result?.id ?? "", sellerId: result?.seller?.id ?? 0), model: result ?? Results.getModelResultBasic()), isActive: $isPresentedProductDetail) { EmptyView() }
            LazyVGrid(columns: colums, spacing: 15) {
                ForEach(self.viewModel.results, id: \.id) { result in
                    NavigationLink(destination: ProductDetailView(viewModel: ProductDetailViewModel(itemId: result.id ?? "", sellerId: result.seller?.id ?? 0), model: result)) {
                        OtherProductsViewCell(model: result, isLoading: viewModel.isLoading, cellFrame: (width: cardWidth(), height: 270))
                    }
                    .disabled(viewModel.isLoading)
                }
            }
            .padding(.horizontal, 5)
            .padding(.bottom, 10)
            .navigationTitle(categoryName)
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationBarItems(trailing:
            HStack {
                Button {
                    self.isPresentedSearchBar.toggle()
                } label: {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .font(Font.system(size: 17))
                        .foregroundColor(CustomColor.lightYellow)
                }
            }
        )
        .onAppear {
            viewModel.getProductsByCategory(categoryId: categoryId)
        }
        .popup(isPresented: $viewModel.shouldShowNetworkError) {
            ErrorAlertView(isPresented: $viewModel.shouldShowNetworkError, text: Constants.messageNetworkError, image: nil, confirm: { viewModel.shouldShowNetworkError = false })
        }
        .popup(isPresented: $viewModel.shouldShowFuntionalityError) {
            ErrorAlertView(isPresented: $viewModel.shouldShowFuntionalityError, text: Constants.messageErrorGeneric, image: Image(Constants.imageErrorServiceGeneral), confirm: {
                viewModel.shouldShowFuntionalityError = false
                goToBack.wrappedValue.dismiss()
            })
        }
        .fullScreenCover(isPresented: $isPresentedSearchBar) {
            isPresentedProductDetail = false
        } content: {
            ProductHomeView(didGoToDetail: { result in
                self.result = result
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.isPresentedProductDetail = true
                }
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
