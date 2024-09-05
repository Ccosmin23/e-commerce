//
//  ProductDetailsView.swift
//  e-commerce-8x8
//
//  Created by Cosmin Cosan - tapptitude on 05.09.2024.
//

import SwiftUI
import Kingfisher

struct ProductDetailsView: View {
    let product: Product
    
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
    }
}

//MARK: - view components
extension ProductDetailsView {
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
            .foregroundStyle(.purple)
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
