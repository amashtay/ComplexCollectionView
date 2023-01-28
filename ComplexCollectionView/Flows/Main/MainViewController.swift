//
//  MainViewController.swift
//  ComplexCollectionView
//
//  Created by Александр Тонхоноев on 28.01.2023.
//

import UIKit

class MainViewController: UIViewController {

    let presenter: MainViewOutput
    
    // MARK: Initializer
    
    init(presenter: MainViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View's lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.magenta
        presenter.onViewDidLoad()
    }
    
}

extension MainViewController: MainViewInput {
    
}

