//
//  ProductDetailView.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 20/03/22.
//

import SwiftUI
import SDWebImageSwiftUI
import SkeletonUI

struct ProductDetailView: View {
    
    @Environment(\.presentationMode) var goBack
    @ObservedObject var viewModel = ProductDetailViewModel(itemId: "", sellerId: 0)
    @State private var quantityModel: QuantityModel = QuantityModel()
    @State private var showBuyAlert: Bool = false
    @State private var showBuyAlertDone: Bool = false
    @State private var isPresentedSearchBar: Bool = false
    @State private var isPresentedProductDetail: Bool = false
    @State private var result: Results?
    var model: Results
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                NavigationLink(destination: ProductDetailView(viewModel: ProductDetailViewModel(itemId: result?.id ?? "", sellerId: result?.seller?.id ?? 0), model: result ?? Results.getModelResultBasic()), isActive: $isPresentedProductDetail) { EmptyView() }
                Group {
                    let parameter = self.model.soldQuantity ?? 0
                    let soldQuantity = parameter > 0 ? "| \(parameter) vendidos" : ""
                    Text("\(self.model.condition?.productState() ?? "") \(soldQuantity)")
                        .font(Font.custom(FontName.regular.rawValue, size: 12))
                        .foregroundColor(CustomColor.opaqueGray)
                    Text(self.model.title ?? "")
                        .font(Font.custom(FontName.medium.rawValue, size: 17))
                        .padding(1)
                    VStack {
                        AnimatedImage(url: URL(string: self.model.thumbnail?.replaceHttpUrl() ?? Constants.defaultImage))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 300)
                    }
                    .frame(maxWidth: .infinity, minHeight: 300, maxHeight: 300)
                    Text("\(self.model.price)".toPriceNumber())
                        .font(Font.custom(FontName.regular.rawValue, size: 25))
                        .padding(.top, 15)
                    HStack {
                        if (self.model.acceptsMercadopago ?? false) && (self.model.installments?.quantity ?? 0) > 0 {
                            let quantity = self.model.installments?.quantity ?? 0
                            let quota = quantity > 1 ? "cuotas" : "cuota"
                            Image(systemName: "creditcard")
                                .font(.system(size: 20))
                            Text("Hasta \(quantity) \(quota)")
                                .font(Font.custom(FontName.regular.rawValue, size: 15))
                        }
                    }
                    .padding(.top, 3)
                    HStack {
                        Image(systemName: "cart")
                            .font(.system(size: 20))
                            .skeleton(with: viewModel.isLoadingSeller, transition: .slide)
                        VStack(alignment: .leading) {
                            Text(self.viewModel.sellerModel?.seller?.nickname ?? "NA")
                                .font(Font.custom(FontName.regular.rawValue, size: 14))
                            Text("\(self.viewModel.sellerModel?.seller?.sellerReputation?.metrics?.sales.completed ?? 0) Ventas")
                                .font(.custom(FontName.regular.rawValue, size: 14))
                        }
                        .skeleton(with: viewModel.isLoadingSeller, transition: .slide)
                    }
                    .padding(.top, 1)
                    .accessibility(hidden: viewModel.shouldShowSellerFuntionalityError)
                }
                // MARK: - QuantityButton
                Group {
                    if (self.model.availableQuantity ?? 0) > 1 {
                        VStack {}.frame(minWidth: 0, maxWidth: .infinity, minHeight: 1).background(.gray).padding(.vertical, 10)
                        VStack {
                            Button {
                                self.quantityModel.isPresend.toggle()
                            } label: {
                                HStack {
                                    Text("Cantidad: ")
                                        .font(Font.custom(FontName.regular.rawValue, size: 15))
                                        .foregroundColor(CustomColor.darkGray)
                                    + Text("\(self.quantityModel.quantity)")
                                        .font(Font.custom(FontName.bold.rawValue, size: 14))
                                        .foregroundColor(CustomColor.darkGray)
                                    Text("(\(self.model.availableQuantity ?? 0) disponible)")
                                        .font(Font.custom(FontName.regular.rawValue, size: 14))
                                        .foregroundColor(CustomColor.lightText)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color.blue)
                                        .font(.system(size: 20))
                                }
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity)
                            }
                            .background(CustomColor.lightGray)
                            .cornerRadius(7)
                        }
                        VStack {}.frame(minWidth: 0, maxWidth: .infinity, minHeight: 1).background(.gray).padding(.vertical, 10)
                    } else {
                        Text("??Ultimo(a) disponible!")
                            .font(Font.custom(FontName.bold.rawValue, size: 20))
                            .padding(15)
                    }
                    // MARK: - BuyButtons
                    VStack(alignment: .center, spacing: 10) {
                        Button {
                            self.showBuyAlert.toggle()
                        } label: {
                            VStack {
                                Text("Comprar Ahora")
                                    .padding()
                                    .foregroundColor(Color.white)
                                    .font(Font.custom(FontName.medium.rawValue, size: 14))
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                        }
                        .background(Color.blue)
                        .cornerRadius(7)
                        if let url = URL(string: self.model.permalink ?? "") {
                            Link(destination: url) {
                                Text("Comprar desde la web")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(CustomColor.gentleBlue)
                                    .font(Font.custom(FontName.medium.rawValue, size: 14))
                                    .foregroundColor(Color.blue)
                                    .cornerRadius(7)
                            }
                        }
                    }
                    VStack {
                        HStack {
                            Image(systemName: "arrow.uturn.left")
                                .font(.system(size: 12))
                            Text("Devoluci??n gratis.")
                                .font(Font.custom(FontName.regular.rawValue, size: 12))
                                .foregroundColor(Color.blue)
                            + Text(" Tienes 30 d??as desde que lo recibes.")
                                .font(Font.custom(FontName.regular.rawValue, size: 12))
                                .foregroundColor(CustomColor.opaqueGray)
                        }
                        .padding(.vertical, 5)
                    }
                    VStack {
                        HStack {
                            Image(systemName: "lock")
                                .font(.system(size: 12))
                            Text("Compra Protegida,")
                                .font(Font.custom(FontName.regular.rawValue, size: 12))
                                .foregroundColor(Color.blue)
                            + Text(" recibe el producto que esperabas o te devolvemos tu dinero.")
                                .font(Font.custom(FontName.regular.rawValue, size: 12))
                                .foregroundColor(CustomColor.opaqueGray)
                        }
                    }
                    VStack {}.frame(minWidth: 0, maxWidth: .infinity, minHeight: 1).background(.gray).padding(.vertical, 10)
                }
                VStack (alignment: .leading) {
                    Text("Descripci??n")
                        .font(Font.custom(FontName.bold.rawValue, size: 20))
                    Text(self.viewModel.descriptionModel?.plainText ?? "")
                        .font(Font.custom(FontName.regular.rawValue, size: 14))
                        .padding(.top, 3)
                        .skeleton(with: viewModel.isLoadingDescription, transition: .slide)
                }
                .accessibility(hidden: viewModel.shouldShowDescriptionFuntionalityError)
            }
            .padding([.leading, .top, .trailing])
            VStack {
                Group {
                    VStack(alignment: .leading) {
                        Text("Otros productos")
                            .font(Font.custom(FontName.bold.rawValue, size: 20))
                            .padding([.top, .leading])
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(self.viewModel.sellerModel?.results ?? [Results](), id: \.id) { product in
                                    NavigationLink(destination: ProductDetailView(viewModel: ProductDetailViewModel(itemId: product.id ?? "", sellerId: product.seller?.id ?? 0), model: product)) {
                                        OtherProductsViewCell(model: product, isLoading: viewModel.isLoadingSeller)
                                            .padding(.horizontal, 5)
                                            .padding(.vertical, 7)
                                    }
                                    .disabled(viewModel.isLoadingSeller)
                                }
                            }
                            .padding([.horizontal, .bottom], 10)
                        }
                    }
                    .accessibility(hidden: viewModel.shouldShowSellerFuntionalityError)
                }
            }
        }
        .navigationTitle("Detalle")
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
            if (model.availableQuantity ?? 0) >= 1 {
                for i in 1...(model.availableQuantity ?? 0) {
                    quantityModel.quantityArray.append(i)
                }
            }
        }
        .popup(isPresented: $viewModel.shouldShowDescriptionFuntionalityError) {
            ErrorAlertView(isPresented: $viewModel.shouldShowDescriptionFuntionalityError, text: Constants.messageErrorDescription, image: Image(Constants.imageErrorServiceGeneral), confirm: {
                viewModel.shouldShowDescriptionFuntionalityError = false
            })
        }
        .popup(isPresented: $viewModel.shouldShowSellerFuntionalityError) {
            ErrorAlertView(isPresented: $viewModel.shouldShowSellerFuntionalityError, text: Constants.messageErrorSeller, image: Image(Constants.imageErrorServiceGeneral), confirm: {
                viewModel.shouldShowSellerFuntionalityError = false
            })
        }
        .popup(isPresented: self.$showBuyAlert) {
            ErrorAlertView(isPresented: self.$showBuyAlert, text: "??Estas seguro que deseas realizar la compra de este producto? \n\n Cantidad: \(self.quantityModel.quantity)", image: Image("iconQuestion"), confirm: {
                self.showBuyAlert.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.showBuyAlertDone.toggle()
                }
            }) {
                self.showBuyAlert.toggle()
            }
        }
        .popup(isPresented: self.$showBuyAlertDone) {
            ErrorAlertView(isPresented: self.$showBuyAlertDone, text: "??Felicitaciones!\nLa compra se ha realizado de forma exitosa", image: Image("iconRight"), confirm: {
                self.goBack.wrappedValue.dismiss()
            })
        }
        .popup(isPresented: self.$quantityModel.isPresend) {
            SelectQuantityView(quantityModel: self.$quantityModel)
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
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(model: Results.getModelResultBasic(""))
    }
}
