//
//  CustomCell.swift
//  rxSwiftTableViewTutorial
//
//  Created by 강병우 on 2020/09/09.
//  Copyright © 2020 강병우. All rights reserved.
//

import UIKit

import Then
import SnapKit

class CustomCell: UITableViewCell {

    // MARK: - View
    let justLabel = UILabel().then {
        $0.textColor = .black
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(justLabel)
        
        justLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
