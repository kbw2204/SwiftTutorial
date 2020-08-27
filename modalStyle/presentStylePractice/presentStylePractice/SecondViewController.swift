//
//  SecondViewController.swift
//  presentStylePractice
//
//  Created by 강병우 on 2020/08/27.
//  Copyright © 2020 강병우. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    // MARK: - View
    let backgoundView: UIView = {
       let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let alertCustomView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - View Life Cycle
    override func loadView() {
        let view = UIView()
        self.view = view
        
        [backgoundView, alertCustomView].forEach {
            self.view.addSubview($0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraint()
    }
    
    func setConstraint() {
        NSLayoutConstraint.activate([
            backgoundView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            backgoundView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            backgoundView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
            backgoundView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            
            alertCustomView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            alertCustomView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            alertCustomView.heightAnchor.constraint(equalToConstant: 168),
            alertCustomView.widthAnchor.constraint(equalToConstant: 224)
        ])
    }
}
