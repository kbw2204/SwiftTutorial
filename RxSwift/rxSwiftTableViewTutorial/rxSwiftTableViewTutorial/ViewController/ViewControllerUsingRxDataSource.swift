//
//  ViewControllerUsingRx1.swift
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
import RxDataSources

class ViewControllerUsingRxDataSource: UIViewController {
    
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
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfCustomData>(configureCell: { dataSource, tableView, indexPath, item in
            
            guard let cell = tableView.dequeue(Reusable.defaultCell) else { return UITableViewCell()}
            cell.textLabel?.text = "CustomData 값의 title: \(item.title)"
            
            return cell
        })
        
        // 헤더 사용하고 싶다면 추가
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].header // SectionOfCustomData 의 header
        }
        
        // 이부분을 어떻게하면 이쁘게 집어넣을수 있을까.. =_=.. viewModel에서 이쁘게 가져오고 싶었는데..
        let sections = [
            SectionOfCustomData(header: "엣헴", items: [CustomData(title: "1"), CustomData(title: "2")]),
            SectionOfCustomData(header: "엣헴2", items: [CustomData(title: "3"), CustomData(title: "0")])
        ]
        
        // 추가로 요렇게 설정 가능
        dataSource.canEditRowAtIndexPath = {dataSource, indexPath in true}
        dataSource.canMoveRowAtIndexPath = {dataSource, indexPath in true}
        
        // 마지막으로 뿌려준다.
        Observable.just(sections)
            .bind(to: tableView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
    }
}

