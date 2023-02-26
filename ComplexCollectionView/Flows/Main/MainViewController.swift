//
//  MainViewController.swift
//  ComplexCollectionView
//
//  Created by Александр Тонхоноев on 28.01.2023.
//

import UIKit

class MainViewController: UIViewController {
    typealias Item = MainSectionViewModel.ItemType
    typealias DataSource = UICollectionViewDiffableDataSource<MainSectionViewModel, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<MainSectionViewModel, Item>

    let presenter: MainViewOutput
    let animator: CustomDetailsTransitionAnimator
    
    private var collectionView: UICollectionView!
    
    private lazy var dataSource = createDataSource()
    
    private var viewModel = MainViewModel(sections: [])
    
    // MARK: Initializer
    
    init(presenter: MainViewOutput,
         animator: CustomDetailsTransitionAnimator) {
        self.presenter = presenter
        self.animator = animator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View's lifecycle
    
    override func loadView() {
        super.loadView()
        setupCollectionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        presenter.onViewDidLoad()
    }
    
    // MARK: Private
    
    private func setupCollectionView() {
        collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: createCollectionLayout()
        )
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(BatchLoadingCell.self,
                                forCellWithReuseIdentifier: BatchLoadingCell.cellReuseId)
        collectionView.register(CardCell.self,
                                forCellWithReuseIdentifier: CardCell.cellReuseId)
        collectionView.register(ItemsListCell.self,
                                forCellWithReuseIdentifier: ItemsListCell.cellReuseId)
        
        collectionView.contentInset.bottom = 44
    }
    
    private func createCollectionLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { [self] (sectionIndex, _) -> NSCollectionLayoutSection? in
            guard sectionIndex < viewModel.sections.count else { return  nil }
            
            let sectionViewModel = viewModel.sections[sectionIndex]
            switch sectionViewModel.type {
            case .cards:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .fractionalHeight(1.0)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 4.0, leading: 4.0, bottom: 4.0, trailing: 4.0)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalWidth(0.5)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            case .list, .batchUpdate:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 4.0, leading: 4.0, bottom: 4.0, trailing: 4.0)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalWidth(0.2)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            }
        }
    }
    
    private func createDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, item in
            self?.cell(at: indexPath, item: item)
        }
        return dataSource
    }
    
    private func cell(at indexPath: IndexPath, item: Item) -> UICollectionViewCell? {
        switch item {
        case .card(let cardViewModel):
            if let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CardCell.cellReuseId,
                for: indexPath
            ) as? CardCell {
                cell.configure(title: cardViewModel.title)
                return cell
            }
        case .listItem(let itemViewModel):
            if let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ItemsListCell.cellReuseId,
                for: indexPath
            ) as? ItemsListCell {
                cell.configure(number: itemViewModel.number)
                return cell
            }
        case .batch:
            if let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BatchLoadingCell.cellReuseId,
                for: indexPath
            ) as? BatchLoadingCell {
                cell.startAnimation()
                return cell
            }

        }
        return nil
    }
}

extension MainViewController: MainViewInput {
    
    func update(with viewModel: MainViewModel) {
        self.viewModel = viewModel
        let sections = viewModel.sections
        
        var snapshot = Snapshot()
        snapshot.appendSections(sections)
        sections.forEach { section in
            snapshot.appendItems(section.items, toSection: section)
        }

        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.section == viewModel.sections.count - 1,
           indexPath.row == viewModel.sections[indexPath.section].count - 1 {
            DispatchQueue.main.async {
                self.presenter.onBatchUpdate()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch viewModel.sections[indexPath.section].items[indexPath.row] {
        case .card(let cellModel):
            cellModel.action?()
        default:
            break
        }
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard
            let indexPath = collectionView.indexPathsForSelectedItems?.first,
            let cell = collectionView.cellForItem(at: indexPath),
            let cellSuperview = cell.superview
        else {
            return nil
        }
        
        animator.originFrame = cellSuperview.convert(cell.frame, to: nil)
        return animator
    }
}
