//
//  EmptyStateViewCell.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 23/03/22.
//

import SwiftUI

struct EmptyStateViewCell: View {
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .foregroundColor(CustomColor.indicatorGray)
                    .frame(width: 90, height: 90)
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 40))
                    .foregroundColor(Color.white)
                    .padding()
            }
            .padding()
            Text("No encontramos publicaciones")
                .font(Font.custom(FontName.regular.rawValue, size: 17))
                .foregroundColor(CustomColor.darkText)
                .multilineTextAlignment(.center)
            Text("Revisa que la palabra esté bien escrita. También puedes probar con menos términos o mas generales.")
                .font(Font.custom(FontName.regular.rawValue, size: 15))
                .foregroundColor(CustomColor.darkBlur)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .padding(.vertical, 5)
                .multilineTextAlignment(.center)
        }
    }
}

struct EmptyStateViewCell_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateViewCell()
    }
}
