//
//  DetailsWireframe.swift
//  ComplexCollectionView
//
//  Created by Александр Тонхоноев on 28.01.2023.
//

import Foundation

final class DetailsWireframe {
    
    
    
    func createViewController(configurationData: String) -> DetailsViewController {
        let viewController = DetailsViewController()
        viewController.title = configurationData
        return viewController
    }
}
