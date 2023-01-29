//
//  CardCell.swift
//  ComplexCollectionView
//
//  Created by Александр Тонхоноев on 29.01.2023.
//

import UIKit

class CardCell: UICollectionViewCell {
    static let cellReuseId = "CardCell"
    
    private let label = UILabel()
    
    // MARK: Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: Internal
    
    func configure(title: String) {
        label.text = title
    }
    
    // MARK: Private
    
    private func setup() {
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 4.0
        backgroundColor = UIColor.white
        
        label.isHidden = false
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
