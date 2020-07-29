//
//  TableViewCell.swift
//  rxTableViewController
//
//  Created by 강병우 on 2020/07/28.
//  Copyright © 2020 강병우. All rights reserved.
//

import UIKit

import Then

class TableViewCell: UITableViewCell {

    let titleLabel = UILabel().then {
        $0.textAlignment = .left
        $0.adjustsFontSizeToFitWidth = true
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(self.snp.left).offset(10)
            $0.centerY.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
