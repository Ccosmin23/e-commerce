//
//  Product.swift
//  e-commerce-8x8
//
//  Created by Cosmin Cosan - tapptitude on 05.09.2024.
//

import Foundation

struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: ProductRating?
    let quantity: Int?
    
    var formattedPrice: String {
        let count = quantity ?? 1
        let total: Double = Double(count) * price
        
        return "$" + String(format: "%g", total)
    }
}

struct ProductRating: Codable {
    let rate: Double
    let count: Int
}

//MARK: - mock
extension Product {
    static let mockProduct1 = Product(
        id: 0,
        title: "CCmock1 - Foldsack No. 1 Backpack, Fits 15 Laptops",
        price: 11.11,
        description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
        category: "child's clothing",
        image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
        rating: ProductRating(rate: 1.1, count: 1111),
        quantity: nil
    )
    
    static let mockProduct2 = Product(
        id: 1,
        title: "CCmock2 - Foldsack No. 1 Backpack, Fits 15 Laptops",
        price: 22.2,
        description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
        category: "women's clothing",
        image: "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
        rating: ProductRating(rate: 1.2, count: 222),
        quantity: nil
    )
    
    static let mockProduct3 = Product(
        id: 2,
        title: "CCmock3 - Foldsack No. 1 Backpack, Fits 15 Laptops",
        price: 333,
        description: "Publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying",
        category: "men's clothing",
        image: "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
        rating: ProductRating(rate: 1.3, count: 33),
        quantity: 22
    )
    
    static let mockProducts: [Product] = [.mockProduct1, .mockProduct2, .mockProduct3]
}
