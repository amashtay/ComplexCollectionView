//
//  AppDelegate.swift
//  ComplexCollectionView
//
//  Created by Александр Тонхоноев on 28.01.2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let applicationWireframe = ApplicationWireframe()
    
    private var appCoordinator: ApplicationCoordinator?
    
    // MARK: UIApplicationDelegate

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
    -> Bool {
        // Override point for customization after application launch.
        setup()
        return true
    }
    
    // MARK: Private
    
    private func setup() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = applicationWireframe.createApplicationCoordinator(window: window)
        appCoordinator?.start()
    }
}

