//
//  DefaultCell.swift
//  rxSwiftTableViewTutorial
//
//  Created by 강병우 on 2020/08/27.
//  Copyright © 2020 강병우. All rights reserved.
//

import UIKit

import SnapKit

class DefaultCell: UITableViewCell {

    // MARK: - view
    let titleLabel = UILabel()
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(titleLabel)
        
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    func setConstraint() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
        }
    }
}
