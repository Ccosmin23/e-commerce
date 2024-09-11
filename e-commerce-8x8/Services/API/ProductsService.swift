//
//  ProductsService.swift
//  e-commerce-8x8
//
//  Created by Cosmin Cosan - on 05.09.2024.
//

import Foundation
import Alamofire

protocol ProductsServiceProtocol {
    static func getAllProducts() async throws -> [Product]
}

final class ProductsService: ProductsServiceProtocol {
    
    @discardableResult
    static func getAllProducts() async throws -> [Product] {
        return try await API.request(
            method: .get,
            path: "products",
            of: [Product].self
        )
    }
}
