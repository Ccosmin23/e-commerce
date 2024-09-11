//
//  ProductListViewModel.swift
//  e-commerce-8x8
//
//  Created by Cosmin Cosan - on 05.09.2024.
//

import Foundation

final class ProductListViewModel: ObservableObject {
    @Published var productsList = [Product]()
    @Published var isLoading = false
    
    init() {
        loadProducts()
    }
}

extension ProductListViewModel {
    private func loadProducts() {
        Task { @MainActor [weak self] in
            do {
                self?.isLoading = true
                self?.productsList = try await ProductsService.getAllProducts()
            } catch {
                print(error.localizedDescription)
            }
            
            self?.isLoading = false
        }
    }
}
