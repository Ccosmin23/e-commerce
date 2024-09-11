//
//  ProductsListView.swift
//  e-commerce-8x8
//
//  Created by Cosmin Cosan - tapptitude on 05.09.2024.
//

import SwiftUI
import Kingfisher

struct ProductsListView: View {
    @ObservedObject var viewModel: ProductListViewModel
    
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
extension ProductsListView {
    private var contentView: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 25) {
                ForEach(viewModel.productsList, id: \.id) { product in
                    customNavigationLink(with: product)
                    Divider()
                }
            }
        }
    }
    
    private func customNavigationLink(with product: Product) -> some View {
        NavigationLink {
            ProductDetailsView(product: product)
        } label: {
            ProductCellView(product: product, shouldShowQuantity: false, completion: nil)
        }
    }
}

//MARK: - preview
#Preview("ProductsListView") {
    ProductsListView(viewModel: ProductListViewModel())
}
