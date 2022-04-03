//
//  SearchView.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 26/03/22.
//

import SwiftUI

struct SearchView: View {
    
    var didTapSearchBar: (() -> Void)?
    var didStartSearch: ((String) -> Void)?
    var didXMark: (() -> Void)?
    @Binding var text: String
    @State var preventStartEditing: Bool
    @State private var isEditing: Bool = false
    
    var body: some View {
        HStack {
            TextField("Buscar en Mercado Libre", text: $text, onCommit: {
                didStartSearch?(text)
            })
                .foregroundColor(CustomColor.darkText)
                .font(Font.custom(FontName.regular.rawValue, size: 14))
                .onTapGesture {
                    didTapSearchBar?()
                    if !preventStartEditing {
                        self.isEditing = true
                    }
                }
                .padding(.vertical, 7)
                .padding(.horizontal, 32)
                .background(CustomColor.lightWhite)
                .cornerRadius(16)
                .overlay(
                    HStack {
                        let magnifyingGlass = Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(width: 16, height: 16)
                            .padding(8)
                        if isEditing {
                            Button(action: {
                                didStartSearch?(text)
                            }, label: {
                                magnifyingGlass
                            })
                            Spacer()
                            Button(action: {
                                self.isEditing = false
                                self.text = ""
                                didXMark?()
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }, label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(CustomColor.darkText)
                                    .frame(width: 20, height: 20)
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 11)
                            })
                        } else {
                            magnifyingGlass
                            Spacer()
                        }
                    }
                )
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .disabled(preventStartEditing)
        }
        .onTapGesture {
            didTapSearchBar?()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(text: .constant(""), preventStartEditing: false)
    }
}
