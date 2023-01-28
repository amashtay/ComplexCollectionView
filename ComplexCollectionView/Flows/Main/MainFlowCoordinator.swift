//
//  MainFlowCoordinator.swift
//  ComplexCollectionView
//
//  Created by Александр Тонхоноев on 28.01.2023.
//

import UIKit

final class MainFlowCoordinator: RootFlowCoordinator {
    private let wireframe = MainWireframe()
    private var detailsCoordinator: FlowCoordinator?
    
    // MARK: Coordinator
    
    func instantiateRootViewController() -> UIViewController {
        let viewController = wireframe.createMainViewController()
        viewController.presenter.onOpenDetails = { [weak self] id in
            guard let self = self else { return }
            self.detailsCoordinator = self.wireframe.createDetailsCoordinator(configurationData: id)
            self.detailsCoordinator?.start(from: viewController)
        }
        return viewController
    }
}
