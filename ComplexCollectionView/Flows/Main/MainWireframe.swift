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
        let viewController = MainViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
    
    private func createMainPresenter() -> MainPresenter {
        MainPresenter()
    }
    
    // MARK: Details flow
    
    func createDetailsCoordinator(configurationData: String) -> IDetailsFlowCoordinator {
        DetailsFlowCoordinator(configurationData: configurationData)
    }
}
