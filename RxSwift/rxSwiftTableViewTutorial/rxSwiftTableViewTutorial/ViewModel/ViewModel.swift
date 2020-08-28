//
//  viewModel.swift
//  rxSwiftTableViewTutorial
//
//  Created by 강병우 on 2020/08/27.
//  Copyright © 2020 강병우. All rights reserved.
//

protocol ViewModelProtocol {
    var data: [String] { get }
}

class ViewModel: ViewModelProtocol {
    
    let data = ["안녕하세용", "저는 개발자 아라찌", "입니당"]
}
