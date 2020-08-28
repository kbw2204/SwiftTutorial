//
//  ViewController.swift
//  rxTableViewController
//
//  Created by 강병우 on 2020/07/28.
//  Copyright © 2020 강병우. All rights reserved.
//

import UIKit

import SnapKit
import RxCocoa
//import RxDataSources
import RxSwift

class ViewController: UIViewController {

    typealias citySectionModel = SectionModel<String, String>
    typealias dataSource = RxTableViewSectionedReloadDataSource<citySectionModel>
    
    let disposBag = DisposeBag()
    let tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "\(TableViewCell.self)")
//        tableView.dataSource = self
        bindTableView()
    }

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemBackground
        self.view = view
        
        view.addSubview(tableView)
    }
    
    func bindTableView() {
        let citis = ["test1", "test2", "test3"]
        let citiesOb: Observable<[String]> = Observable.of(citis)
        citiesOb.bind(to: tableView.rx.items) { (tableView: UITableView, index: Int, element: String) -> TableViewCell in
            if let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "\(TableViewCell.self)") as? TableViewCell {
                cell.titleLabel.text = element
                return cell
            }
            return TableViewCell()
        }.disposed(by: disposBag)
    }
    
}

//extension ViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "\(TableViewCell.self)", for: indexPath) as? TableViewCell {
//            cell.titleLabel.text = "test"
//            return cell
//        }
//        return TableViewCell()
//    }
//}
