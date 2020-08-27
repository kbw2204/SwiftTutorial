//
//  ViewController.swift
//  presentStylePractice
//
//  Created by 강병우 on 2020/08/27.
//  Copyright © 2020 강병우. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = .yellow
    }

    @IBAction func tapAction(_ sender: UIButton) {
        let nextViewController = SecondViewController()
        
        nextViewController.modalPresentationStyle = .formSheet
            
        present(nextViewController, animated: true)
    }
    
}

