//
//  ProductViewCell.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 23/03/22.
//

import SwiftUI
import SDWebImageSwiftUI
import SkeletonUI

struct ProductViewCell: View {
    
    var model: Results
    var isLoading: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack {
                    AnimatedImage(url: URL(string: self.model.thumbnail?.replaceHttpUrl() ?? Constants.defaultImage))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                        .skeleton(with: isLoading, size: CGSize(width: 100, height: 100), transition: .slide)
                }
                .frame(width: 100, height: 100)
                VStack(alignment: .leading) {
                    Text(self.model.title ?? "")
                        .font(Font.custom(FontName.regular.rawValue, size: 14))
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .skeleton(with: isLoading, size: CGSize(width: 160, height: 15), transition: .slide)
                    Text("\(self.model.price)".toPriceNumber())
                        .font(Font.custom(FontName.semibold.rawValue, size: 18))
                        .multilineTextAlignment(.leading)
                        .padding(.top, 1)
                        .skeleton(with: isLoading, size: CGSize(width: 160, height: 15), transition: .slide)
                    if self.model.acceptsMercadopago ?? false {
                        let quantity = self.model.installments?.quantity
                        let amount = self.model.installments?.amount
                        VStack {
                            Text("\(String(quantity ?? 0))x ")
                                .font(Font.custom(FontName.regular.rawValue, size: 14))
                            + Text(String(amount ?? 0).toPriceNumber())
                                .font(Font.custom(FontName.regular.rawValue, size: 14))
                        }
                        .padding(.bottom, 5)
                    }
                    VStack(alignment: .leading) {
                        Text("Disponible: ")
                            .font(Font.custom(FontName.medium.rawValue, size: 14))
                        + Text("\(self.model.availableQuantity ?? 0)")
                            .font(Font.custom(FontName.medium.rawValue, size: 14))
                        Text(self.model.condition?.productState() ?? "")
                            .padding(.top, 1)
                            .font(Font.custom(FontName.regular.rawValue, size: 12))
                            .multilineTextAlignment(.leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .skeleton(with: isLoading, size: CGSize(width: 130, height: 15), transition: .slide)
                }
                .padding(.horizontal)
            }
        }
        .frame(maxHeight: 150)
        .padding()
    }
}

struct ProductViewCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductViewCell(model: Results.getModelResultBasic(""), isLoading: false)
    }
}
