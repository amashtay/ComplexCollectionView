//
//  MainWireframe.swift
//  ComplexCollectionView
//
//  Created by Александр Тонхоноев on 28.01.2023.
//

import UIKit

final class MainWireframe {
    
    // MARK: Main flow
        
    func createMainViewController() -> MainViewController {
        let presenter = createMainPresenter()
        let customTransitionAnimator = customTransitionAnimator()
        let viewController = MainViewController(
            presenter: presenter,
            animator: customTransitionAnimator
        )
        presenter.view = viewController
        return viewController
    }
    
    private func createMainPresenter() -> MainPresenter {
        MainPresenter()
    }
    
    private func customTransitionAnimator() -> CustomDetailsTransitionAnimator {
        CustomDetailsTransitionAnimator()
    }
    
    // MARK: Details flow
    
    func createDetailsCoordinator(configurationData: String) -> IDetailsFlowCoordinator {
        DetailsFlowCoordinator(configurationData: configurationData)
    }
}
