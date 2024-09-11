//
//  RootCoordinator.swift
//  e-commerce-8x8
//
//  Created by Cosmin Cosan - on 05.09.2024.
//

import Foundation
import SwiftUI

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

        
        let viewModel = MainViewModel()
        let view = MainView(viewModel: viewModel)
        
        let viewController = UIHostingController(rootView: view)
        navigationController.pushViewController(viewController, animated: true)
    }
}
