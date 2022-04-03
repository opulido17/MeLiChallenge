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
    @ObservedObject var viewModel = ProductDetailViewModel()
    @State private var quantityModel: QuantityModel = QuantityModel()
    @State private var showBuyAlert: Bool = false
    @State private var showBuyAlertDone: Bool = false
    var model: Results
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
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
                        VStack(alignment: .leading) {
                            Text(self.viewModel.sellerModel?.seller?.nickname ?? "NA")
                                .font(Font.custom(FontName.regular.rawValue, size: 14))
                            Text("\(self.viewModel.sellerModel?.seller?.sellerReputation?.metrics?.sales.completed ?? 0) Ventas")
                                .font(.custom(FontName.regular.rawValue, size: 14))
                        }
                    }
                    .padding(.top, 1)
                    .skeleton(with: viewModel.isLoadingSeller, transition: .slide)
                }
                // MARK: - QuantityButton
                Group {
                    if (self.model.availableQuantity ?? 0) > 0 {
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
                                        .foregroundColor(.blue)
                                        .font(.system(size: 20))
                                }
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity)
                            }
                            .background(CustomColor.lightGray)
                            .cornerRadius(7)
                        }
                        .padding(.horizontal, 40)
                        VStack {}.frame(minWidth: 0, maxWidth: .infinity, minHeight: 1).background(.gray).padding(.vertical, 10)
                    } else {
                        Text("¡Ultimo(a) disponible!")
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
                                    .foregroundColor(.white)
                                    .font(Font.custom(FontName.medium.rawValue, size: 14))
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                        }
                        .background(.blue)
                        .cornerRadius(7)
                        if let url = URL(string: self.model.permalink ?? "") {
                            Link(destination: url) {
                                Text("Comprar desde la web")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(CustomColor.gentleBlue)
                                    .font(Font.custom(FontName.medium.rawValue, size: 14))
                                    .foregroundColor(.blue)
                                    .cornerRadius(7)
                            }
                        }
                    }
                    VStack {
                        HStack {
                            Image(systemName: "arrow.uturn.left")
                                .font(.system(size: 12))
                            Text("Devolución gratis.")
                                .font(Font.custom(FontName.regular.rawValue, size: 12))
                                .foregroundColor(.blue)
                            + Text(" Tienes 30 días desde que lo recibes.")
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
                                .foregroundColor(.blue)
                            + Text(" recibe el producto que esperabas o te devolvemos tu dinero.")
                                .font(Font.custom(FontName.regular.rawValue, size: 12))
                                .foregroundColor(CustomColor.opaqueGray)
                        }
                    }
                    VStack {}.frame(minWidth: 0, maxWidth: .infinity, minHeight: 1).background(.gray).padding(.vertical, 10)
                }
                VStack (alignment: .leading) {
                    Text("Descripción")
                        .font(Font.custom(FontName.bold.rawValue, size: 20))
                    Text(self.viewModel.descriptionModel?.plainText ?? "")
                        .font(Font.custom(FontName.regular.rawValue, size: 14))
                        .padding(.top, 3)
                        .skeleton(with: viewModel.isLoadingDescription, transition: .slide)
                }
                Group {
                    Text("Otros productos")
                        .font(Font.custom(FontName.bold.rawValue, size: 16))
                        .padding(.top)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(self.viewModel.sellerModel?.results ?? [Results](), id: \.id) { product in
                                NavigationLink(destination: ProductDetailView(model: product)) {
                                    OtherProductsViewCell(model: product, isLoading: viewModel.isLoadingDescription)
                                        .padding(.horizontal, 5)
                                        .padding(.vertical, 7)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Detail")
            .padding()
            .onAppear {
                DispatchQueue.main.async {
                    self.viewModel.getProductDescription(itemId: self.model.id ?? "")
                }
                DispatchQueue.main.async {
                    self.viewModel.getInfoSellerId(sellerId: self.model.seller?.id ?? 0)
                }
                for i in 1...(model.availableQuantity ?? 0) {
                    quantityModel.quantityArray.append(i)
                }
            }
        }
        .popup(isPresented: $viewModel.shouldShowDescriptionFuntionalityError) {
            ErrorAlertView(isPresented: $viewModel.shouldShowDescriptionFuntionalityError, text: Constants.messageErrorDescription, image: Image("errorServiceGeneral"), confirm: {
                viewModel.shouldShowDescriptionFuntionalityError = false
            })
        }
        .popup(isPresented: $viewModel.shouldShowSellerFuntionalityError) {
            ErrorAlertView(isPresented: $viewModel.shouldShowSellerFuntionalityError, text: Constants.messageErrorSeller, image: Image("errorServiceGeneral"), confirm: {
                viewModel.shouldShowSellerFuntionalityError = false
            })
        }
        .popup(isPresented: self.$showBuyAlert) {
            ErrorAlertView(isPresented: self.$showBuyAlert, text: "¿Estas seguro que deseas realizar la compra de este producto? \n Cantidad: \(self.quantityModel.quantity)", image: Image("iconQuestion"), confirm: {
                self.showBuyAlert.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.showBuyAlertDone.toggle()
                }
            }) {
                self.showBuyAlert.toggle()
            }
        }
        .popup(isPresented: self.$showBuyAlertDone) {
            ErrorAlertView(isPresented: self.$showBuyAlertDone, text: "¡Felicitaciones!\nLa compra se ha realizado de forma exitos", image: Image("iconRight"), confirm: {
                self.goBack.wrappedValue.dismiss()
            })
        }
        .popup(isPresented: self.$quantityModel.isPresend) {
            SelectQuantityView(quantityModel: self.$quantityModel)
                .transition(.move(edge: .bottom))
                .animation(.default)
            //.animation(.interpolatingSpring(mass: 0.5, stiffness: 100, damping: 15, initialVelocity: 0))
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(model: Results.getModelResultBasic(""))
    }
}
