//
//  MainViewIO.swift
//  ComplexCollectionView
//
//  Created by Александр Тонхоноев on 28.01.2023.
//

import Foundation

protocol MainViewInput: AnyObject {
    
}

protocol MainViewOutput: AnyObject {
    var onOpenDetails: ((_ id: String) -> Void)? { get set }
    func onViewDidLoad()
}
