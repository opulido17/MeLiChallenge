//
//  ProductHomeView.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 20/03/22.
//

import SwiftUI
import SkeletonUI

struct ProductHomeView: View {
    
    @Environment(\.presentationMode) var goBack
    @ObservedObject var viewModel = ProductHomeViewModel()
    @State private var searchText: String = ""
    @State private var xMark: Bool = false
    @State private var time = Timer.publish(every: 0.1, on: .main, in: .tracking).autoconnect()
    var didTapSearchBar: (() -> Void)?
    var didStartSearch: ((String) -> Void)?
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                HStack(spacing: 4) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color.white)
                        .font(Font.custom(FontName.bold.rawValue, size: 20))
                        .onTapGesture {
                            self.goBack.wrappedValue.dismiss()
                        }
                    SearchView(didTapSearchBar: didTapSearchBar, didStartSearch: { searchText in
                        xMark = false
                        viewModel.searchProduct(searchText: searchText)
                    }, didXMark: {
                        xMark = true
                        viewModel.removeData()
                    }, text: self.$searchText, preventStartEditing: false)
                    Spacer(minLength: 0)
                }
                .padding()
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .background(CustomColor.lightYellow)
                Spacer(minLength: 0)
                if viewModel.searchResult.count > 0 && !viewModel.shouldShowFuntionalityError {
                    List {
                        ForEach(self.viewModel.searchResult, id: \.id) { result in
                            ZStack {
                                if self.viewModel.searchResult.last?.id == result.id && !viewModel.isLoading {
                                    GeometryReader { g in
                                        VStack {
                                            ProductViewCell(model: result, isLoading: result.shimmer ?? false)
                                        }
                                        .onAppear {
                                            self.time = Timer.publish(every: 0.1, on: .main, in: .tracking).autoconnect()
                                        }
                                        .onReceive(self.time) { (_) in
                                            if !viewModel.isLoadingReload {
                                                if g.frame(in: .global).maxY < UIScreen.main.bounds.height - 110 {
                                                    print("Update data ...")
                                                    viewModel.updateSearchProduct(searchText: self.searchText)
                                                    self.time.upstream.connect().cancel()
                                                }
                                            }
                                        }
                                    }
                                    .frame(height: 150)
                                } else {
                                    NavigationLink(destination: ProductDetailView(model: result, viewModel: ProductDetailViewModel(itemId: result.id ?? "", sellerId: result.seller?.id ?? 0))) {
                                        ProductViewCell(model: result, isLoading: viewModel.isLoading)
                                    }
                                    .disabled(viewModel.isLoading)
                                }
                            }
                        }
                    }
                } else {
                    if viewModel.shouldShowFuntionalityError && !xMark {
                        EmptyStateViewCell()
                        Spacer(minLength: 0)
                    }
                }
            }
            .background(Color.black.opacity(0.05).edgesIgnoringSafeArea(.all))
            .edgesIgnoringSafeArea(.top)
        }
        .navigationBarHidden(true)
        .navigationBarTitle("Test")
        .listStyle(GroupedListStyle())
    }
}


struct ProductHomeView_Previews: PreviewProvider {
    static var previews: some View {
        ProductHomeView()
    }
}
