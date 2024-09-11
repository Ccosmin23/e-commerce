//
//  CartRealmObject.swift
//  e-commerce-8x8
//
//  Created by Cosmin Cosan - tapptitude on 11.09.2024.
//

import Foundation
import RealmSwift

class CartProductRealmObject: Object {
    @Persisted var productID: Int
    @Persisted var quantity: Int
    
    override class func primaryKey() -> String? {
        "productID"
    }
}

extension CartProductRealmObject {
    func convertToCoreModel() -> CartProduct {
        CartProduct(
            productID: self.productID,
            quantity: self.quantity
        )
    }
}

extension CartProduct {
    func convertToRealmObject() -> CartProductRealmObject {
        let realmObject = CartProductRealmObject()
        
        realmObject.productID = self.productID
        realmObject.quantity = self.quantity
        return realmObject
    }
}
