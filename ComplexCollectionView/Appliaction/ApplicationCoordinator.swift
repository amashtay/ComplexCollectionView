//
//  ApplicationCoordinator.swift
//  ComplexCollectionView
//
//  Created by Александр Тонхоноев on 28.01.2023.
//

import UIKit

final class ApplicationCoordinator {
    
    private let window: UIWindow
    private let rootCoordinator: RootFlowCoordinator
    
    // MARK: Initializer
    
    init(window: UIWindow,
         rootCoordinator: RootFlowCoordinator) {
        self.window = window
        self.rootCoordinator = rootCoordinator
    }
    
    // MARK: Coordinator
    
    func start() {
        window.rootViewController = rootCoordinator.instantiateRootViewController()
        window.makeKeyAndVisible()
    }
}
