//
//  MainView.swift
//  e-commerce-8x8
//
//  Created by Cosmin Cosan - on 11.09.2024.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        TabView {
            productsListView
            cartView
        }
    }
}

extension MainView {
    private var productsListView: some View {
        ProductsListView(viewModel: viewModel.productsListViewModel)
            .tabItem {
                Label("Home", systemImage: "menucard")
            }
    }
    
    private var cartView: some View {
        CartView(viewModel: viewModel.cartViewModel)
            .tabItem {
                Label("Cart", systemImage: "cart.circle")
            }
    }
}

#Preview {
    MainView(viewModel: MainViewModel())
}
