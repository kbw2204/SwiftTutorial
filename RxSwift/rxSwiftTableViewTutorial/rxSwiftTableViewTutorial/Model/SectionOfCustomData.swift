//
//  SectionOfCustomData.swift
//  rxSwiftTableViewTutorial
//
//  Created by 강병우 on 2020/08/27.
//  Copyright © 2020 강병우. All rights reserved.
//

import RxDataSources

struct SectionOfCustomData {
    var header: String // 필요 없으면 안써도 됨
    var items: [Item]
}

extension SectionOfCustomData: SectionModelType {
    
    typealias Item = CustomData
    
    init(original: SectionOfCustomData, items: [Item]) {
        self = original
        self.items = items
    }
}
