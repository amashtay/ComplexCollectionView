//
//  ICoordinator.swift
//  ComplexCollectionView
//
//  Created by Александр Тонхоноев on 28.01.2023.
//

import UIKit

protocol FlowCoordinator: AnyObject {
    func start(from viewController: UIViewController)
}

protocol RootFlowCoordinator: AnyObject {
    func instantiateRootViewController() -> UIViewController
}
