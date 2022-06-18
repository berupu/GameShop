//
//  SearchBar.swift
//  GameShop
//
//  Created by Ashraful Islam Rupu on 6/7/22.
//

import SwiftUI

struct SearchBar: View {
    
    @StateObject var mainPageVM: MainPageVM = MainPageVM()
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading, 5)
            TextField("Search", text: $mainPageVM.searchText)
                .textCase(.lowercase)
                .disableAutocorrection(true)
        }
        .frame(width: getScreen().width / 1.45, height: 40)
        .background(
            ZStack {
                Capsule()
                    .strokeBorder(.gray, lineWidth: 1.5)
            }
        )
        
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}
