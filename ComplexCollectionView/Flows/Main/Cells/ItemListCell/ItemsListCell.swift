//
//  ItemsListCell.swift
//  ComplexCollectionView
//
//  Created by Александр Тонхоноев on 29.01.2023.
//

import UIKit

class ItemsListCell: UICollectionViewCell {
    static let cellReuseId = "ItemsListCell"
    
    private let image = UIImageView(image: UIImage(systemName: "heart.fill"))
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
    
    func configure(number: Int) {
        label.text = "Number -- \(number)"
    }
    
    // MARK: Private
    
    private func setup() {
        addSubview(image)
        image.tintColor = .red
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            image.widthAnchor.constraint(equalTo: image.heightAnchor)
        ])
        
        addSubview(label)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
}
