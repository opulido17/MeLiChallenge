//
//  EmptyStateGeneric.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 4/04/22.
//

import SwiftUI

struct EmptyStateGeneric: View {
    
    var didTapTryAgain: (() -> Void)?
    
    var body: some View {
        VStack {
            Image(Constants.imageErrorServiceGeneral)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
            Text("¡Ocurrió un error al cargar la información!")
                .font(Font.custom(FontName.regular.rawValue, size: 25))
                .foregroundColor(CustomColor.darkGray)
                .multilineTextAlignment(.center)
            Button {
                didTapTryAgain?()
            } label: {
                Text("Intentar nuevamente")
                    .padding()
                    .background(Color.blue)
                    .font(Font.custom(FontName.semibold.rawValue, size: 18))
                    .foregroundColor(Color.white)
            }
            .cornerRadius(10)
        }
    }
}

struct EmptyStateGeneric_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateGeneric()
    }
}
