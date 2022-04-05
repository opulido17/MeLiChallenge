//
//  HomeView.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 28/03/22.
//

import SwiftUI
import SkeletonUI

struct HomeView: View {
    
    @Environment(\.presentationMode) var goBack
    @ObservedObject var viewModel = HomeViewModel()
    @State private var searchText = ""
    @State private var isActive: Bool = false
    var didTapSearchBar: (() -> Void)?
    var didStartSearch: ((String) -> Void)?
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 0) {
                    ZStack {
                        SearchView(didTapSearchBar: didTapSearchBar, didStartSearch: didStartSearch, text: self.$searchText, preventStartEditing: true)
                        NavigationLink(destination: ProductHomeView(), isActive: $isActive) {
                            Button {
                                isActive.toggle()
                            } label: {
                                Text("")
                                    .frame(maxWidth: .infinity)
                                    .padding([.top, .leading, .trailing])
                            }
                        }
                        Spacer(minLength: 0)
                    }
                    .padding()
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .background(CustomColor.lightYellow)
                    Spacer(minLength: 0)
                    if viewModel.categoryList.count > 0 {
                        ScrollView(.vertical, showsIndicators: true) {
                            VStack(alignment: .leading) {
                                Text("Categorias")
                                    .font(Font.custom(FontName.semibold.rawValue, size: 17))
                                    .padding([.top, .leading], 15)
                                Divider()
                                ForEach(viewModel.categoryList, id: \.id) { result in
                                    NavigationLink(destination: ProductByCategoryView(categoryId: result.id, categoryName: result.name)) {
                                        HStack(spacing: 10) {
                                            Image(systemName: "chart.bar.doc.horizontal")
                                                .foregroundColor(.blue)
                                                .font(.system(size: 20))
                                                .skeleton(with: viewModel.isLoading, size: CGSize(width: 40, height: 40), transition: .slide)
                                            Text(result.name)
                                                .font(Font.custom(FontName.regular.rawValue, size: 17))
                                                .foregroundColor(CustomColor.darkGray)
                                                .skeleton(with: viewModel.isLoading, transition: .slide)
                                        }
                                        .padding()
                                    }
                                    Divider()
                                        .padding(.leading, 30)
                                }
                            }
                            .background(.white)
                            .cornerRadius(10)
                            .padding(10)
                            .shadow(radius: 2)
                        }
                    } else {
                        EmptyStateGeneric {
                            self.viewModel.getCategories()
                        }
                        Spacer(minLength: 0)
                    }
                }
                .background(Color.black.opacity(0.05).edgesIgnoringSafeArea(.all))
                .edgesIgnoringSafeArea(.top)
            }
            .navigationBarHidden(true)
            .onAppear {
                self.viewModel.getCategories()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
