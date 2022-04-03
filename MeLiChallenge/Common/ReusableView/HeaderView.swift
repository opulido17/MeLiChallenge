//
//  HeaderView.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 26/03/22.
//

import SwiftUI

struct HeaderView: View {
    
    var didTapSearchBar: (() -> Void)?
    var didStartSearch: ((String) -> Void)?
    @State private var searchText = ""
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 2) {
                SearchView(didTapSearchBar: didTapSearchBar, didStartSearch: didStartSearch, text: self.$searchText, preventStartEditing: false)
                Spacer(minLength: 0)
            }
            .padding()
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            .background(CustomColor.lightYellow)
            Spacer(minLength: 0)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
