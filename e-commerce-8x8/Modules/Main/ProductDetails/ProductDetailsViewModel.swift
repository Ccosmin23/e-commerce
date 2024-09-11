//
//  ProductDetailsViewModel.swift
//  e-commerce-8x8
//
//  Created by Cosmin Cosan - tapptitude on 05.09.2024.
//

import Foundation

final class ProductDetailsViewModel: ObservableObject {
    
    func addToCart(productID: Int) {
        CacheManager.shared.saveProduct(with: productID)
        ToastMessage.show(message: "Product has been added successful to cart")
        
        print(CacheManager.shared.getAllCartProducts() ?? "missing data")
    }
}
