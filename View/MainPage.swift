//
//  MainPage.swift
//  GameShop
//
//  Created by Ashraful Islam Rupu on 6/7/22.
//

import SwiftUI

struct MainPage: View {
    
    @Namespace var productTypeAnimation
    
    @StateObject var mainPageVM: MainPageVM = MainPageVM()
    
    var body: some View {
        VStack {
            SearchBar()
            Text("Order to Fill \nthe Cart")
                .font(.system(size: 25))
                .bold()
                .frame(maxWidth: .infinity, maxHeight: 60, alignment: .leading)
                .padding()
            
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(ProductType.allCases, id: \.self){ type in
                        
                        ProductViewType(type: type)
                            .padding(.horizontal, 10)
                    }
                }
            }
            .padding(.horizontal,20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(mainPageVM.filteredProducts, id: \.self){ product in
                        ProductViewCard(product: product)
                    }
                }
            }
            .padding(.top, 20)
            Spacer()
        }
        .onChange(of: mainPageVM.productType, perform: { newValue in
            mainPageVM.filteredByProductType()
            //Works fine on Simulator.
        })
        .background(.gray.opacity(0.2))
        
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
    
    
    // Product Category VM
    @ViewBuilder
    func ProductViewType(type: ProductType) -> some View {
        Button {
            withAnimation {
                mainPageVM.productType = type
            }
        } label: {
            Text(type.rawValue)
                .font(.system(size: 18))
                .foregroundColor(.gray)
                .bold()
                .padding(.bottom, 5)
                .overlay(
                    ZStack{
                        if mainPageVM.productType == type {
                            Capsule()
                                .fill(Color.purple)
                                .matchedGeometryEffect(id: "PRODUCTTYPE", in: productTypeAnimation)
                                .frame(height: 2)
                        }
                        else {
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                        
                    }
                    //.padding(.horizontal, -5)
                    ,alignment: .bottom
                )
        }
        
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
