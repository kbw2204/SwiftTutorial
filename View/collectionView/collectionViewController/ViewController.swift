//
//  ViewController.swift
//  collectionViewController
//
//  Created by 강병우 on 2020/08/18.
//  Copyright © 2020 강병우. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Property
    let palette: [UIColor] = [.red, .orange, .yellow, .green, .blue]

    // MARK: - View
    private var collectionView: UICollectionView?
    
    // MARK: - View Life Cycle
    override func loadView() {
        let view = UIView()
        self.view = view
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .init(), collectionViewLayout: flowLayout)
        self.collectionView = collectionView
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
            collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    // MARK: - func
    func initialize() {
        // MARK: collectionView register 추가
        collectionView?.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "\(CustomCollectionViewCell.self)")
        
        // MARK: delegate, dataSource 추가
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
}


// MARK: - extension
extension ViewController: UICollectionViewDataSource {
    // MARK: cell count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return palette.count
    }
    
    // MARK: cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: CustomCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CustomCollectionViewCell.self)", for: indexPath) as? CustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.backgroundColor = palette[indexPath.item]
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
    // MARK: selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.item)번 Cell 클릭")
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: cellSize
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let cellItemForRow: CGFloat = 3
        let minimumSpacing: CGFloat = 2
        
        let width = (collectionViewWidth - (cellItemForRow - 1) * minimumSpacing) / cellItemForRow
        
        return CGSize(width: width, height: width)
    }
    
    // MARK: minimumSpacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
