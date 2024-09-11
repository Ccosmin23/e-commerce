//
//  ProductRealmObject.swift
//  e-commerce-8x8
//
//  Created by Cosmin Cosan - on 05.09.2024.
//

import Foundation
import RealmSwift

class ProductRealmObject: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String
    @Persisted var price: Double
    @Persisted var details: String
    @Persisted var category: String
    @Persisted var image: String
    @Persisted var rateValue: Double
    @Persisted var rateCount: Int
    
    override class func primaryKey() -> String? {
        "id"
    }
}

//MARK: - conversion methods
extension ProductRealmObject {
    func convertToCoreModel() -> Product {
        Product(
            id: self.id,
            title: self.title,
            price: self.price,
            description: self.details,
            category: self.category,
            image: self.image,
            rating: ProductRating(rate: self.rateValue, count: self.rateCount),
            quantity: nil
        )
    }
}

extension Product {
    func convertToRealmObject() -> ProductRealmObject {
        let realmObject = ProductRealmObject()
        
        realmObject.id = self.id
        realmObject.title = self.title
        realmObject.price = self.price
        realmObject.details = self.description
        realmObject.category = self.category
        realmObject.image = self.image
        realmObject.rateValue = self.rating?.rate ?? 0
        realmObject.rateCount = self.rating?.count ?? 0
        
        return realmObject
    }
}
