//
//  ErrorAlertView.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 28/03/22.
//

import SwiftUI

struct ErrorAlertView: View {
    
    @Binding var isPresented: Bool
    var text: String
    let image: Image?
    var confirm: (() -> Void)?
    var cancel: (() -> Void)?
    
    var body: some View {
        ZStack {
            CustomColor.darkBlur
                .ignoresSafeArea()
            VStack {
                if let image = image {
                    image.resizable()
                        .aspectRatio(contentMode: .fit).frame(width: 70).padding(.top, 20.0)
                    Text(text)
                        .font(Font.custom(FontName.regular.rawValue, size: 14))
                        .foregroundColor(CustomColor.darkText)
                        .padding([.leading, .bottom, .trailing], 30.0)
                } else {
                    Text(text)
                        .font(Font.custom(FontName.regular.rawValue, size: 14))
                        .foregroundColor(CustomColor.darkText).padding().padding(.top, 10)
                }
                HStack {
                    Spacer()
                    if let _ = cancel {
                        Button(action: {
                            cancel?()
                        }, label: {
                            Text("Cancelar")
                                .font(Font.custom(FontName.bold.rawValue, size: 14))
                                .foregroundColor(CustomColor.darkText)
                        }).padding(.trailing, 20)
                    }
                    if let _ = confirm {
                        Button(action: {
                            confirm?()
                        }, label: {
                            Text("Aceptar")
                                .font(Font.custom(FontName.bold.rawValue, size: 14))
                                .foregroundColor(CustomColor.blueAction)
                        }).padding(.trailing, 20)
                    }
                }
                .padding(.bottom, 26)
            }
            .frame(idealWidth: 306, minHeight: 145, idealHeight: 145)
            .background(Color.white)
            .cornerRadius(16)
            .padding()
        }
    }
}

struct ErrorAlertView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorAlertView(isPresented: .constant(true), text: "Parece que tienes problema de conexión asegurate de que estes conectado a internet.", image: Image("errorServiceGeneral"))
    }
}
