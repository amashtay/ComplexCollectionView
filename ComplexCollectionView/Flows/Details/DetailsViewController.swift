//
//  DetailsViewController.swift
//  ComplexCollectionView
//
//  Created by Александр Тонхоноев on 28.01.2023.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    var onClose: (() -> Void)?
    
    // MARK: Initializer
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View's lifecycle
    
    override func loadView() {
        super.loadView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Close",
            style: .plain,
            target: self,
            action: #selector(closeAction)
        )
        view.backgroundColor = UIColor.lightGray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Private
    
    @objc private func closeAction() {
       onClose?()
    }
}
