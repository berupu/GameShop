//
//  Product.swift
//  GameShop
//
//  Created by Ashraful Islam Rupu on 6/7/22.
//

import Foundation



struct Product: Identifiable, Hashable {
    var id = UUID().uuidString
    var type: ProductType
    var productName: String
    var description: String
    var price: String
    var availability: Bool
}

enum ProductType: String, CaseIterable {
    case Games = "Games"
    case GiftCards = "Cards"
    case Accessories = "Accessories"
}


