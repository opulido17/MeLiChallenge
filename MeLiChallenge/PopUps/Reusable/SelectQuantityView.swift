//
//  SelectQuantityView.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 30/03/22.
//

import SwiftUI

struct SelectQuantityView: View {
    
    @Binding var quantityModel: QuantityModel
    
    var body: some View {
        ZStack {
            Spacer()
            CustomColor.clearBackground
                .ignoresSafeArea()
            VStack {
                Spacer()
                VStack {
                    Text("Selecciona una cantidad")
                        .bold()
                        .font(Font.custom(FontName.regular.rawValue, size: 16))
                        .padding(.top, 15)
                    Picker("Cantidad", selection: self.$quantityModel.quantity) {
                        ForEach(quantityModel.quantityArray, id: \.self) { quantity in
                            Text("\(quantity) und")
                        }
                    }
                    .pickerStyle(InlinePickerStyle())
                    Divider()
                    Button {
                        self.quantityModel.isPresend.toggle()
                    } label: {
                        Text("Aplicar")
                            .font(Font.custom(FontName.semibold.rawValue, size: 18))
                            .padding(.bottom, 50)
                    }
                }
                .background(Color.white)
                .cornerRadius(10)
                .frame(height: 300)
            }
            .ignoresSafeArea()
        }
    }
}

struct SelectQuantityView_Previews: PreviewProvider {
    static var previews: some View {
        SelectQuantityView(quantityModel: .constant(QuantityModel()))
    }
}
