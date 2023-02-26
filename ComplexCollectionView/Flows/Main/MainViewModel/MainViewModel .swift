//
//  MainViewModel .swift
//  ComplexCollectionView
//
//  Created by Александр Тонхоноев on 29.01.2023.
//

import Foundation

struct MainViewModel: Equatable {
    let sections: [MainSectionViewModel]
    
    // MARK: Internal
    
    func recreate(_ sections: [MainSectionViewModel]) -> MainViewModel {
        MainViewModel(sections: sections)
    }
}

struct MainSectionViewModel: Hashable {
    
    enum SectionLayoutType: Hashable {
        case cards
        case list
        case batchUpdate
    }
    
    enum ItemType: Hashable {
        case card(MainViewCardViewModel)
        case listItem(MainViewListItemViewModel)
        case batch(Bool)
    }
    
    let sectionId: String
    let type: SectionLayoutType
    let items: [ItemType]
    
    var count: Int { items.count }
    
    // MARK: Initializer
    
    init(sectionId: String = UUID().uuidString,
         type: SectionLayoutType,
         items: [ItemType]) {
        self.sectionId = sectionId
        self.type = type
        self.items = items
    }
    
    // MARK: Internal
    
    func recreate(items: [ItemType]) -> MainSectionViewModel {
        MainSectionViewModel(sectionId: self.sectionId,
                             type: self.type,
                             items: items)
    }
}

struct MainViewCardViewModel: Hashable {
    let uuid = UUID()
    let title: String
    
    let action: (() -> Void)?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    static func == (lhs: MainViewCardViewModel, rhs: MainViewCardViewModel) -> Bool {
        lhs.uuid == rhs.uuid
    }
}

struct MainViewListItemViewModel: Hashable {
    let uuid = UUID()
    let number: Int
    
    let action: (() -> Void)?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    static func == (lhs: MainViewListItemViewModel, rhs: MainViewListItemViewModel) -> Bool {
        lhs.uuid == rhs.uuid
    }
}
