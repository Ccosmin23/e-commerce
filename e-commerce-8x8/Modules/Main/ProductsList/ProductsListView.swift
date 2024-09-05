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
            navigationLinkLabel(with: product)
        }
    }
    
    private func navigationLinkLabel(with product: Product) -> some View {
        HStack(spacing: 35) {
            productImage(with: URL(string: product.image))
            productTitle(with: product)
            Spacer()
            productPrice(with: product)
        }
        .padding(.horizontal, 24)
    }
    
    @ViewBuilder
    private func productImage(with url: URL?) -> some View {
        KFImage(url)
            .placeholder({ productImagePlaceholder })
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .frame(width: 50, height: 50)
    }
    
    private var productImagePlaceholder: some View {
        ZStack {
            Color.green
                .clipShape(RoundedRectangle(cornerRadius: 12))

            Text("CC")
                .foregroundStyle(.white)
        }
        .frame(width: 50, height: 50)
    }
    
    private func productTitle(with product: Product) -> some View {
        Text(product.title)
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
    }
    
    @ViewBuilder
    private func productPrice(with product: Product) -> some View {
        Text(product.formattedPrice)
            .bold()
    }
}

//MARK: - preview
#Preview("ProductsListView") {
    ProductsListView(viewModel: ProductListViewModel())
}
