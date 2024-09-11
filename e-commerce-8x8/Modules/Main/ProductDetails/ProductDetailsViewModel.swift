//
//  ProductDetailsViewModel.swift
//  e-commerce-8x8
//
//  Created by Cosmin Cosan - on 05.09.2024.
//

import Foundation

final class ProductDetailsViewModel: ObservableObject {
    @Published var productsList = [Product]()
    
    func randomProductsList(productID: Int) {
        Task { @MainActor [weak self] in
            do {
                let products = try await ProductsService.getAllProducts()
                
                let filterArray = products.filter({ $0.id != productID })
                self?.productsList = Array(filterArray.prefix(5)).shuffled()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func addToCart(product: Product) {
        CacheManager.shared.saveProduct(with: product.id)
        ProductObservable.shared.notifyAboutChanges(product)

        ToastMessage.show(message: "Product has been added successful to cart")        
        print(CacheManager.shared.getAllCartProducts() ?? "missing data")
    }
}
