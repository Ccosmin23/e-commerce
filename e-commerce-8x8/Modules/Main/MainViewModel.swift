//
//  MainViewModel.swift
//  e-commerce-8x8
//
//  Created by Cosmin Cosan - tapptitude on 11.09.2024.
//

import Foundation

final class MainViewModel: ObservableObject {
    
    init() {
        #if DEBUG
        print(CacheManager.shared.getAllCartProducts() ?? [])
        #endif
        
//        CacheManager.shared.deleteAllProducts()
    }
    
    lazy var productsListViewModel: ProductListViewModel = {
        ProductListViewModel()
    }()
    
    lazy var cartViewModel: CartViewModel = {
        CartViewModel()
    }()
}
