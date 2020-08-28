//
//  ViewController.swift
//  rxSwiftTableViewTutorial
//
//  Created by 강병우 on 2020/08/27.
//  Copyright © 2020 강병우. All rights reserved.
//

import UIKit

import Then
import SnapKit
import ReusableKit
import RxSwift

class ViewControllerUsingRxSwift: UIViewController {
    
    // MARK: - Constants
    struct Reusable {
        static let defaultCell = ReusableCell<DefaultCell>()
    }
    
    // MARK: - Property
    private var viewModel: ViewModelProtocol
    var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - View
    let tableView = UITableView().then {
        $0.register(Reusable.defaultCell)
    }
    
    // MARK: - init
    init(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemBackground
        self.view = view
        
        [tableView].forEach {
            self.view.addSubview($0)
        }
        
        tableView.snp.makeConstraints {
            $0.center.edges.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindingTableView()
    }

    // MARK: - Binding
    func bindingTableView() {
        
        Observable.just(viewModel.data)
            .bind(to: tableView.rx.items(Reusable.defaultCell)) { _, item, cell in
                cell.titleLabel.text = item
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                let data = self.viewModel.data
                print("\(indexPath.row)번째 Cell: \(data[indexPath.row])")
            }).disposed(by: disposeBag)
    }
}
