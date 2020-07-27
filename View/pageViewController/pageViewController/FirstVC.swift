//
//  FirstVC.swift
//  pageViewController
//
//  Created by 강병우 on 2020/07/01.
//  Copyright © 2020 강병우. All rights reserved.
//

import UIKit

class FirstVC: UIViewController {
    
    // MARK: - Property
    weak var label: UILabel?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .yellow
        self.view = view
        
        let label = UILabel()
        self.label = label
        label.text = "첫번째 뷰"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }

}
