//
//  RootCoordinator.swift
//  e-commerce-8x8
//
//  Created by Cosmin Cosan - tapptitude on 05.09.2024.
//

import Foundation
import UIKit

final class RootCoordinator {
    weak var window: UIWindow?
    weak var navigationController: UINavigationController?

    func start(in window: UIWindow) {
        let navigationController = UINavigationController()
        
        self.window = window
        self.window?.rootViewController = navigationController
        self.navigationController = navigationController
        
        guard let navigationController = self.navigationController else {
            return
        }

        let viewController = UIHostingController(rootView: <#T##Content#>)
        navigationController.pushViewController(viewController, animated: true)
    }
}
