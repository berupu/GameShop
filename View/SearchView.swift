//
//  SearchView.swift
//  GameShop
//
//  Created by Ashraful Islam Rupu on 6/18/22.
//

import SwiftUI

struct SearchView: View {
    
    var animation: Namespace.ID
    @EnvironmentObject var mainPageVM: MainPageVM
    @FocusState var textFieldTappedOnApped: Bool
    
    var body: some View {
        VStack {
            HStack{
                Button {
                    withAnimation {
                        mainPageVM.searchFieldTapped = false
                    }
                } label: {
                    Image(systemName: "arrow.left")
                        .padding(.leading,20)
                        .foregroundColor(.black)
                        .frame(width: 50, height: 50)
                }

                SearchBar()
                    .frame(maxWidth: .infinity)
                    .focused($textFieldTappedOnApped)
                    .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
            }
            Spacer()
            
            ScrollView(.vertical, showsIndicators: false) {
                
                if let product = mainPageVM.filteredProductsBySearch {
                    ForEach(product ,id: \.self){ card in
                        ProductViewCard(product: card)
                    }
                } else {
                    ProgressView()
                        .padding(.top, 30)
                        //.opacity(mainPageVM.searchText == "" ? 0 : 1)
                }
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .onAppear {
            textFieldTappedOnApped = true
        }
    }
    
    //Product View Card
    @ViewBuilder
    func ProductViewCard(product: Product) -> some View{
        VStack(spacing: 10) {
            Image(product.productName)
                .resizable()
                .cornerRadius(5)
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
                .offset(y: -80)
                .padding(.bottom, -80)
            
            Text(product.description)
                .font(.system(size: 20))
                .bold()
                .foregroundColor(.gray)
            
            Text(product.price)
                .font(.system(size: 20))
                .bold()
                .foregroundColor(.black)
            
            Text(product.availability ? "Available" : "Out of Stock")
                .font(.system(size: 12))
                .foregroundColor(product.availability ? .green : .red)
                .padding(.bottom, 10)
            
        }
        .background(
            Color.white
                .cornerRadius(25)
        )
        .padding(.top, 80)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
        //SearchView()
    }
}
