//
//  MainPresenter.swift
//  ComplexCollectionView
//
//  Created by Александр Тонхоноев on 28.01.2023.
//

import Foundation

final class MainPresenter: MainViewOutput {
    
    var onOpenDetails: ((_ id: String) -> Void)?
    
    weak var view: MainViewInput?
    
    // MARK: View's lifecycle
    
    func onViewDidLoad() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.onOpenDetails?("ssss")
        }
    }
}
