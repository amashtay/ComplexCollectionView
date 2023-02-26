//
//  DetailsFlowCoordinator.swift
//  ComplexCollectionView
//
//  Created by Александр Тонхоноев on 28.01.2023.
//

import UIKit

protocol IDetailsFlowCoordinator: FlowCoordinator {
    var configurationData: String { get }
}

final class DetailsFlowCoordinator: IDetailsFlowCoordinator {
    var configurationData: String
    
    private let wireframe = DetailsWireframe()
    
    init(configurationData: String) {
        self.configurationData = configurationData
    }
    
    func start(from rootViewController: UIViewController) {
        let viewController = wireframe.createViewController(configurationData: configurationData)
        viewController.onClose = { [weak viewController] in
            viewController?.dismiss(animated: true)
        }
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .custom
        if let rootViewController = rootViewController as? UIViewControllerTransitioningDelegate {
            navigationController.transitioningDelegate = rootViewController
        }
        rootViewController.present(navigationController, animated: true)
    }
}
