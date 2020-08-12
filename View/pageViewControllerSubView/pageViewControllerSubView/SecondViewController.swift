//
//  SecondViewController.swift
//  pageViewControllerSubView
//
//  Created by 강병우 on 2020/08/12.
//  Copyright © 2020 강병우. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    // MARK: - Property
    weak var label: UILabel?
    let index = 1
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .orange
        self.view = view
        
        let label = UILabel()
        self.label = label
        label.text = "두번째 뷰"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
}
