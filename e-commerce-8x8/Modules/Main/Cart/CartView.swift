//
//  CartView.swift
//  e-commerce-8x8
//
//  Created by Cosmin Cosan - tapptitude on 05.09.2024.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel: CartViewModel
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                contentView
            }
        }
    }
}

//MARK: - view components
extension CartView {
    private var contentView: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 25) {
                ForEach(viewModel.productsList, id: \.id) { product in
                    productCellView(for: product)
                    Divider()
                }
            }
        }
    }
    
    private func productCellView(for product: Product) -> some View {
        ProductCellView(
            product: product,
            shouldShowQuantity: true,
            completion: { operation in
                viewModel.handle(operation: operation, for: product.id)
            }
        )
    }
}

//MARK: - preview
#Preview("CartView") {
    CartView(viewModel: CartViewModel())
}
