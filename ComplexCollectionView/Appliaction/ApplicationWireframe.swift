//
//  ApplicationWireframe.swift
//  ComplexCollectionView
//
//  Created by Александр Тонхоноев on 28.01.2023.
//

import UIKit

final class ApplicationWireframe {
    
    func createApplicationCoordinator(window: UIWindow) -> ApplicationCoordinator {
        let rootCoordinator = createRootFlowCoordinator()
        return ApplicationCoordinator(window: window,
                                      rootCoordinator: rootCoordinator)
    }
    
    // MARK: Private
    
    private func createRootFlowCoordinator() -> RootFlowCoordinator {
        MainFlowCoordinator()
    }
}
