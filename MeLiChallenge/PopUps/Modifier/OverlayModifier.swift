//
//  OverlayModifier.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 28/03/22.
//

import SwiftUI

struct OverlayModifier<OverlayView: View>: ViewModifier {
    
    @Binding var isPresend: Bool
    let overlayView: OverlayView
    
    init(isPresend: Binding<Bool>, @ViewBuilder overlayView: @escaping () -> OverlayView) {
        self._isPresend = isPresend
        self.overlayView = overlayView()
    }
    
    func body(content: Content) -> some View {
        content.overlay(isPresend ? overlayView : nil)
    }
}

extension View {
    func popup<OverlayView: View>(isPresented: Binding<Bool>,
                                  @ViewBuilder overlayView: @escaping () -> OverlayView) -> some View {
        return modifier(OverlayModifier(isPresend: isPresented, overlayView: overlayView))
    }
}
