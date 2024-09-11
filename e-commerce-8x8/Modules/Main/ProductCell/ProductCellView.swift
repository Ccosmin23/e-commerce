//
//  ProductCellView.swift
//  e-commerce-8x8
//
//  Created by Cosmin Cosan - on 11.09.2024.
//

import SwiftUI
import Kingfisher

struct ProductCellView: View {
    let product: Product
    let shouldShowQuantity: Bool
    let completion: ((ProductOperation) -> Void)?
    
    var body: some View {
        HStack(spacing: .zero) {
            productImage(with: URL(string: product.image))
            productTitle(with: product)
            Spacer()
            productPrice(with: product)
            
            if shouldShowQuantity {
                Spacer()
                quantityView
            }
        }
        .padding(.horizontal, 24)
    }
}

//MARK: - view components
extension ProductCellView {
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
            .frame(width: 100)
    }
    
    @ViewBuilder
    private func productPrice(with product: Product) -> some View {
        Text(product.formattedPrice)
            .bold()
    }
    
    private var quantityView: some View {
        VStack(spacing: 15) {
            Text(product.quantity?.description ?? "1")
                .multilineTextAlignment(.center)
            
            HStack {
                Button {
                    completion?(.remove)
                } label: {
                    Text("-")
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                Button {
                    completion?(.add)
                } label: {
                    Text("+")
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
        }
    }
}

enum ProductOperation {
    case remove
    case add
}

//MARK: - preview
#Preview {
    ProductCellView(
        product: Product.mockProduct3,
        shouldShowQuantity: true,
        completion: nil
    )
}
