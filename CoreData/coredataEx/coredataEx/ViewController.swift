//
//  ViewController.swift
//  coredataEx
//
//  Created by 강병우 on 2020/10/13.
//  Copyright © 2020 강병우. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let coreData = CoreDataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.dataSource = self
        NotificationCenter.default.addObserver(forName: .NSManagedObjectContextDidSave, object: nil, queue: nil) { notification in
            DispatchQueue.global().async {
                self.coreData.persistentContainer.viewContext.mergeChanges(fromContextDidSave: notification)
                    self.coreData.loadData()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    print("머지")
                }
            }
        }
        DispatchQueue.global().async {
            self.coreData.loadData()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    @IBAction func addAction(_ sender: UIBarButtonItem) {
        coreData.saveData(title: "추가")
    }
    
    @IBAction func refreshAction(_ sender: UIBarButtonItem) {
        self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreData.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? TableViewCell else { fatalError() }
        cell.textLabel?.text = coreData.data[indexPath.row].title
        return cell
    }
}
