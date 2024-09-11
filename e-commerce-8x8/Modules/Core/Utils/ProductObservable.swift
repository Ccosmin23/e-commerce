//
//  ProductObservable.swift
//  e-commerce-8x8
//
//  Created by Cosmin Cosan - on 11.09.2024.
//

import Foundation

/// should be used to extend view models
protocol ProductObserver: AnyObject {
    func productObservable(_ observable: ProductObservableProtocol, didUpdate product: Product)
}

protocol ProductObservableProtocol {
    func addAsObserver(_ observer: ProductObserver)
    func notifyAboutChanges(_ product: Product)
}

final class ProductObservable: ProductObservableProtocol {
    static let shared = ProductObservable()
    private var observers = NSHashTable<AnyObject>.weakObjects()
    
    private var allObservers: [ProductObserver] {
        (observers.allObjects as? [ProductObserver]) ?? []
    }
    
    /// protocol methods
    func addAsObserver(_ observer: ProductObserver) {
        observers.add(observer)
    }
    
    func notifyAboutChanges(_ product: Product) {
        Task { @MainActor in
            allObservers.forEach({ $0.productObservable(self, didUpdate: product) })
        }
    }
}
