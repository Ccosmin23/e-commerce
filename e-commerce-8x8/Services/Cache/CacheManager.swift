//
//  CacheManager.swift
//  e-commerce-8x8
//
//  Created by Cosmin Cosan - tapptitude on 05.09.2024.
//

import Foundation
import RealmSwift

final class CacheManager {
    static let shared = CacheManager()
    
    var realm: Realm? {
        var realm: Realm? = nil
        
        do {
            realm = try Realm(configuration: Realm.Configuration())
        } catch {
            print("Error opening realm: \(error)")
        }
        
        return realm
    }
    
    /// read
    func getAllCartProducts() -> [CartProduct]? {
        guard let objects = realm?.objects(CartProductRealmObject.self) else {
            return nil
        }
        
        let products: [CartProduct] = objects.map { $0.convertToCoreModel() }
        return products
    }
    
    /// add
    func saveProduct(with id: Int) {
        do {
            guard let cartProducts = realm?.objects(CartProductRealmObject.self),
                  let product = cartProducts.first(where: { $0.productID == id })
            else {
                let realmObject = CartProductRealmObject()
                realmObject.productID = id
                realmObject.quantity = 1
                
                try realm?.write {
                    realm?.add(realmObject)
                }
                
                return
            }
            
            let newQuantity = product.quantity + 1
            
            try realm?.write {
                product.quantity = newQuantity
            }
        } catch {
            print("\n \(error)")
        }
    }
    
    /// delete
    func removeProduct(with id: Int) {
        do {
            guard let cartProducts = realm?.objects(CartProductRealmObject.self),
                  let product = cartProducts.first(where: { $0.productID == id })
            else {
                print("\nthere is no product to delete")
                return
            }
            
            let newQuantity = product.quantity - 1
            
            try realm?.write {
                if newQuantity == 0 {
                    realm?.delete(product)
                } else {
                    product.quantity = newQuantity
                }
            }
        } catch {
            print("\n \(error)")
        }
    }
    
    func deleteAllProducts() {
        do {
            try realm?.write {
                realm?.deleteAll()
            }
        } catch {
            print("\n \(error)")
        }
    }
}
