//
//  MainPageVM.swift
//  GameShop (iOS)
//
//  Created by Ashraful Islam Rupu on 6/9/22.
//

import SwiftUI
import Combine

class MainPageVM: ObservableObject {
    
    @Published var productType: ProductType = .Games
    
    
    @Published var searchText: String = ""
    @Published var searchFieldTapped: Bool = false
    @Published var filteredProductsBySearch: [Product]?
    
    @Published var filteredProducts: [Product] = []
    
    var searchCancelable: AnyCancellable?
    
    @Published var productData: [Product] = [
        Product(type: .Games, productName: "bf1", description: "BattleField 1", price: "$28", availability: false),
        Product(type: ProductType.Games, productName: "fifa22", description: "Fifa 22", price: "$52", availability: true),
        Product(type: .Games, productName: "gta5", description: "GTA V", price: "$20", availability: true),
        Product(type: .Accessories, productName: "hdmi", description: "HDMI Cable", price: "$20", availability: false),
        Product(type: .Accessories, productName: "controller", description: "DualShok Controller", price: "$60", availability: true),
        Product(type: .Accessories, productName: "headphone", description: "PS4 Headset", price: "$80", availability: true),
        Product(type: .GiftCards, productName: "ps1month", description: "Plastation Plus 1 Month", price: "$9.99", availability: false),
        Product(type: .GiftCards, productName: "ps3month", description: "Plastation Plus 2 Month", price: "$29.99", availability: true),
        Product(type: .GiftCards, productName: "ps12month", description: "Plastation Plus 12 Month", price: "$59.99", availability: true),
    ]
    
    init(){
        filteredByProductType()
        
        searchCancelable = $searchText.removeDuplicates()
        //Hold Publisher for 0.5 second
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] str in
                guard let self = self else {return}
                
                if str != "" {
                    self.filteredBySearch()
                }else {
                    self.filteredProductsBySearch = nil
                }
            })
        
    }
    
    func filteredByProductType(){
        filteredProducts = productData.filter({$0.type == self.productType})
    }
    
    func filteredBySearch(){
        
        DispatchQueue.main.async(qos: .userInteractive) {
            self.filteredProductsBySearch = self.productData.filter({$0.description.lowercased().contains(self.searchText.lowercased())})
        }
        
    }
    
    
}

