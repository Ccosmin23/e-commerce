//
//  ProductDetailsView.swift
//  e-commerce-8x8
//
//  Created by Cosmin Cosan - on 05.09.2024.
//

import SwiftUI
import Kingfisher

struct ProductDetailsView: View {
    let product: Product
    @StateObject var viewModel = ProductDetailsViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 50) {
                productImageView
                
                VStack(alignment: .center, spacing: 30) {
                    priceView
                    titleAndSubtitle
                }
                
                Spacer()
            }
        }
        .padding(.horizontal, 24)
        .scrollIndicators(.hidden)
        .overlay(addToCartButton, alignment: .bottom)
        .onAppear {
            viewModel.randomProductsList(productID: product.id)
        }
    }
}

//MARK: - view components
extension ProductDetailsView {
    private var otherItemsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(viewModel.productsList, id: \.id) { product in
                    ProductCellView(product: product, shouldShowQuantity: false, completion: nil)
                    Divider()
                }
            }
        }
        .frame(height: 120)
        .background(Color.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .ignoresSafeArea()
    }
    
    private var addToCartButton: some View {
        VStack {
            otherItemsView

            Button {
                viewModel.addToCart(product: product)
            } label: {
                addToCartButtonLabel
            }
        }
    }
    
    private var addToCartButtonLabel: some View {
        ZStack {
            Color.blue
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Text("Add to cart")
                .foregroundStyle(.white)
                .bold()
            
        }
        .padding(.horizontal, 16)
        .frame(height: 50)
        .background(Color.white)
    }
    
    private var titleAndSubtitle: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(product.title)
                .font(.headline)
                .bold()
            
            Text(product.description)
        }
    }
    
    private var priceView: some View {
        Text(product.formattedPrice)
            .foregroundStyle(.blue)
            .font(.title)
            .bold()
    }
    
    private var productImageView: some View {
        KFImage(URL(string: product.image))
            .placeholder({ productImagePlaceholder })
            .resizable()
            .scaledToFit()
            .frame(width: 150, height: 250)
    }
    
    private var productImagePlaceholder: some View {
        ZStack {
            Color.green
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Text("CC")
                .foregroundStyle(.white)
        }
        .frame(width: 150, height: 250)
    }
}

//MARK: - preview
#Preview("ProductDetailsView") {
    ProductDetailsView(product: Product.mockProduct2)
}
