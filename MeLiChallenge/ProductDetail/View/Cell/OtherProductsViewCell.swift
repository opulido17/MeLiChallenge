//
//  OtherProductsViewCell.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 27/03/22.
//

import SwiftUI
import SDWebImageSwiftUI
import SkeletonUI

struct OtherProductsViewCell: View {
    
    var model: Results
    var isLoading: Bool
    var cellFrame: (width: CGFloat, height: CGFloat) = (200, 270)
    
    var body: some View {
        VStack {
            VStack {
                AnimatedImage(url: URL(string: self.model.thumbnail?.replaceHttpUrl() ?? Constants.defaultImage))
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 150)
                    .skeleton(with: isLoading, size: CGSize(width: 100, height: 100), transition: .slide)
            }
            .frame(maxWidth: .infinity, maxHeight: 150)
            Divider()
            VStack(alignment: .leading) {
                Text("\(String(self.model.price).toPriceNumber())")
                    .font(Font.custom(FontName.medium.rawValue, size: 18))
                    .foregroundColor(CustomColor.darkGray)
                    .multilineTextAlignment(.leading)
                    .skeleton(with: isLoading, size: CGSize(width: 165, height: 13), transition: .slide)
                let quantity = self.model.installments?.quantity ?? 0
                let amount = self.model.installments?.amount ?? 0
                Text("\(quantity)x \(String(amount).toPriceNumber())")
                    .font(Font.custom(FontName.regular.rawValue, size: 12))
                    .foregroundColor(CustomColor.darkGray)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 3)
                    .padding(.top, 1)
                    .skeleton(with: isLoading, size: CGSize(width: 130, height: 12), transition: .slide)
                Text(self.model.title)
                    .multilineTextAlignment(.leading)
                    .font(Font.custom(FontName.regular.rawValue, size: 13))
                    .foregroundColor(CustomColor.darkGray)
                    .lineLimit(2)
                    .skeleton(with: isLoading, size: CGSize(width: 90, height: 12), transition: .flipFromLeft)
            }
            .padding(.horizontal, 9)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(width: cellFrame.width, height: cellFrame.height)
        .background(Color.white)
        .cornerRadius(7)
        .shadow(radius: 3.0)
    }
}

struct OtherProductsViewCell_Previews: PreviewProvider {
    static var previews: some View {
        OtherProductsViewCell(model: Results.getModelResultBasic(""), isLoading: true)
    }
}
