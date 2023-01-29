//
//  BatchLoadingCell.swift
//  ComplexCollectionView
//
//  Created by Александр Тонхоноев on 29.01.2023.
//

import UIKit

class BatchLoadingCell: UICollectionViewCell {
    static let cellReuseId = "BatchLoadingCell"
    
    private let activityIndicator = UIActivityIndicatorView(frame: .zero)
    
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
    
    func startAnimation() {
        activityIndicator.startAnimating()
    }
    
    // MARK: Private
    
    private func setup() {
        activityIndicator.isHidden = false
        activityIndicator.hidesWhenStopped = false
        activityIndicator.style = .large
        activityIndicator.color = .white
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: self.topAnchor, constant: 20.0),
            activityIndicator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 20.0),
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
