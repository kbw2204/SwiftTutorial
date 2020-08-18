//
//  CustomCollectionViewCell.swift
//  collectionViewController
//
//  Created by 강병우 on 2020/08/18.
//  Copyright © 2020 강병우. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    weak var imageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imageView = UIImageView()
        self.imageView = imageView
        
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
