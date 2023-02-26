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
    private var state = MainViewState.idle
    private var viewModel = MainViewModel(sections: [])
    
    // MARK: MainViewOutput
    
    func onViewDidLoad() {
        viewModel = createViewModel()
        state = .results(viewModel)
        view?.update(with: viewModel)
    }
    
    func onBatchUpdate() {
        Task { @MainActor [self] in
            guard state != .batch else { return }
            state = .batch
        
            
            viewModel = appendBatchSection(to: viewModel)
            view?.update(with: viewModel)
            
            let batchData = await imitateLoadingData()
            let batchItems = batchData.map { model in
                MainViewCardViewModel(
                    title: model,
                    action: { [weak self] in
                        self?.cardTouched(model)
                    }
                )
            }.map { MainSectionViewModel.ItemType.card($0) }
            
            viewModel = removeBatchSectionIfNeeded(from: viewModel)
            viewModel = append(batchResult: batchItems,
                               to: viewModel)
            state = .results(viewModel)
            view?.update(with: viewModel)
        }
    }
    
    // MARK: Private
    
    private func createViewModel() -> MainViewModel {
        let cards = (0 ... 8)
            .map { model in
                MainViewCardViewModel(
                    title: "\(model)",
                    action: { [weak self] in
                        self?.cardTouched("\(model)")
                    }
                )
            }
            .map {
                MainSectionViewModel.ItemType.card($0)
            }
    
        return MainViewModel(sections: [
            MainSectionViewModel(
                type: .list,
                items: [
                    .listItem(MainViewListItemViewModel(number: 0, action: nil)),
                    .listItem(MainViewListItemViewModel(number: 1, action: nil)),
                ]
            ),
            MainSectionViewModel(
                type: .cards,
                items: cards
            ),
        ])
    }
    
    private func imitateLoadingData() async -> [String] {
        _ = try? await Task.sleep(nanoseconds: 1_000_000_000)
        return (0 ... 8).map {
            "\($0)"
        }
    }
    
    
    private func appendBatchSection(to viewModel: MainViewModel) -> MainViewModel {
        let batchSection =  MainSectionViewModel(
            type: .batchUpdate,
            items: [.batch(true)]
        )
        var sections = viewModel.sections
        sections.append(batchSection)
        return viewModel.recreate(sections)
    }
    
    private func removeBatchSectionIfNeeded(from viewModel: MainViewModel) -> MainViewModel {
        if viewModel.sections.last?.type == .batchUpdate {
            let sections = Array(viewModel.sections.dropLast())
            return viewModel.recreate(sections)
        }
        return viewModel
    }
    
    private func append(batchResult: [MainSectionViewModel.ItemType],
                        to viewModel: MainViewModel) -> MainViewModel {
        if let section = viewModel.sections.last {
            let newSection = section.recreate(items: section.items + batchResult)
            
            var sections = viewModel.sections
            sections[sections.count - 1] = newSection
            return viewModel.recreate(sections)
        }
        return viewModel
    }
    
    private func cardTouched(_ model: String) {
        onOpenDetails?(model)
    }
}
