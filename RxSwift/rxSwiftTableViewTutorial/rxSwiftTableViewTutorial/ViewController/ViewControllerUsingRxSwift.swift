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
        static let customCell = ReusableCell<CustomCell>()
    }
    
    // MARK: - Property
    private var viewModel: ViewModelProtocol
    var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - View
    let tableView = UITableView().then {
        $0.register(Reusable.defaultCell)
        $0.register(Reusable.customCell)
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
        
//        Observable.just(viewModel.data)
//            .bind(to: tableView.rx.items(Reusable.defaultCell)) { _, item, cell in
//                cell.titleLabel.text = item
//        }.disposed(by: disposeBag)
        
        Observable.just(viewModel.data) // 사용할 데이터
            // 클로저를 사용해서 cell을 정의해 줍니다.
            .bind(to: tableView.rx.items) { tableView, row, item in
                let indexPath = IndexPath.init(item: row, section: 0)
                
                if row != 0 {
                    let cell = tableView.dequeue(Reusable.defaultCell, for: indexPath)
                    cell.titleLabel.text = item
                    
                    return cell
                } else {
                    let cell = tableView.dequeue(Reusable.customCell, for: indexPath)
                    cell.justLabel.text = item
                    cell.backgroundColor = .blue
                    
                    return cell
                }
        }.disposed(by: disposeBag)
        
//        tableView.rx.itemSelected
//            .subscribe(onNext: { [weak self] indexPath in
//                guard let self = self else { return }
//                let data = self.viewModel.data
//                print("\(indexPath.row)번째 Cell: \(data[indexPath.row])")
//            }).disposed(by: disposeBag)
    }
}
