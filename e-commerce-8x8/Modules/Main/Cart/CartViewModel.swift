//
//  CartViewModel.swift
//  e-commerce-8x8
//
//  Created by Cosmin Cosan - tapptitude on 11.09.2024.
//

import Foundation

final class CartViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var productsList = [Product]()
    
    init() {
        loadCart()
    }
}

extension CartViewModel {
    private func loadCart() {
        Task { @MainActor [weak self] in
            do {
                self?.isLoading = true
                let products = try await ProductsService.getAllProducts()
                let cachedProducts = CacheManager.shared.getAllCartProducts()
                
                cachedProducts?.forEach { cachedProduct in
                    if var item = products.first(where: { $0.id == cachedProduct.productID }) {
                        item.quantity = cachedProduct.quantity
                        self?.productsList.append(item)
                    }
                }
                
            } catch {
                print(error.localizedDescription)
            }
            
            self?.isLoading = false
        }
    }
    
    func handle(operation: ProductOperation, for productID: Int) {
        switch operation {
        case .remove:
            CacheManager.shared.removeProduct(with: productID)
        case .add:
            CacheManager.shared.saveProduct(with: productID)
        }        
    }
}
