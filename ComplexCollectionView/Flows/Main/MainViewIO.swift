//
//  MainViewIO.swift
//  ComplexCollectionView
//
//  Created by Александр Тонхоноев on 28.01.2023.
//

import Foundation

enum MainViewState: Equatable {
    case idle
    case results(MainViewModel)
    case batch
}

protocol MainViewInput: AnyObject {
    func update(with viewModel: MainViewModel)
}

protocol MainViewOutput: AnyObject {
    var onOpenDetails: ((_ id: String) -> Void)? { get set }
    func onViewDidLoad()
    func onBatchUpdate()
}
