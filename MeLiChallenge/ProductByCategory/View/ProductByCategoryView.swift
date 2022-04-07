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
    var categoryId: String
    var categoryName: String
    let colums: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @State private var isPresented: Bool = false
    
    var body: some View {
        ScrollView {
            Rectangle().foregroundColor(CustomColor.blueRegular).edgesIgnoringSafeArea(.top).frame(height: 0)
            LazyVGrid(columns: colums, spacing: 15) {
                ForEach(self.viewModel.results, id: \.id) { result in
                    NavigationLink(destination: ProductDetailView(model: result, viewModel: ProductDetailViewModel(itemId: result.id ?? "", sellerId: result.seller?.id ?? 0))) {
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
                    self.isPresented.toggle()
                } label: {
                    Image(systemName: "magnifyingglass.circle.fill")
                        .background(CustomColor.lightYellow)
                        .foregroundColor(CustomColor.lightWhite)
                        .cornerRadius(10)
                }
            }
        )
        .popup(isPresented: $viewModel.shouldShowNetworkError) {
            ErrorAlertView(isPresented: $viewModel.shouldShowNetworkError, text: Constants.messageNetworkError, image: nil, confirm: { viewModel.shouldShowNetworkError = false })
        }
        .onAppear {
            viewModel.getProductsByCategory(categoryId: categoryId)
        }
        .popup(isPresented: $viewModel.shouldShowFuntionalityError) {
            ErrorAlertView(isPresented: $viewModel.shouldShowFuntionalityError, text: Constants.messageErrorGeneric, image: Image(Constants.imageErrorServiceGeneral), confirm: {
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
