//
//  TableViewModel.swift
//  rxTableViewController
//
//  Created by 강병우 on 2020/07/28.
//  Copyright © 2020 강병우. All rights reserved.
//

import RxDataSources

class TableViewModel<S: SectionModelType>: TableViewSectionedDataSource<S> {
}

struct SectionModel<Section, ItemType> {
    var model: Section
    var items: [Item]
    
    init(model: Section, items: [Item]) {
        self.model = model
        self.items = items
    }
}

extension SectionModel: SectionModelType {
    typealias Identity = Section
    typealias Item = ItemType
    
    var identity: Section {
        return model
    }
}

