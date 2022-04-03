//
//  LoadingView.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 23/03/22.
//

import Foundation
import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    
    typealias UIViewType = UIActivityIndicatorView
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        uiView.startAnimating()
    }
}

struct ActivityIndicatorView<Content>: View where Content: View {
    
    @Binding var isDisplayed: Bool
    var content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                if !self.isDisplayed {
                    self.content()
                } else {
                    self.content()
                        .disabled(true)
                        .blur(radius: 3)
                    VStack {
                        Text("Cargando...")
                        ActivityIndicator(style: .large)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.secondary)
                    .foregroundColor(Color.black)
                    .cornerRadius(10)
                }
            }
        }
    }
}
