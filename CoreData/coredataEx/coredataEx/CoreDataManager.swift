//
//  CoreDataManager.swift
//  coredataEx
//
//  Created by 강병우 on 2020/10/13.
//  Copyright © 2020 강병우. All rights reserved.
//

import CoreData

class CoreDataManager {
    // MARK: - Core Data stack
    static let shared = CoreDataManager()
    
    var data: [Data] = []
    
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "coredataEx")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func loadData() {
        persistentContainer.viewContext.perform {
            let fetchRequest: NSFetchRequest = Data.fetchRequest()
            let sortd = NSSortDescriptor(keyPath: \Data.title, ascending: true)
            fetchRequest.sortDescriptors = [sortd]
            
            do {
                try self.data = fetchRequest.execute()
            } catch {
                print(error)
            }
        }
    }
    
    func saveData(title: String) {
        persistentContainer.performBackgroundTask { context in
            let data = Data(context: context)
            data.title = title
            do {
                try context.save()
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    func editData(index: Int, title: String) {
        persistentContainer.performBackgroundTask { context in
            let fetchRequest: NSFetchRequest = Data.fetchRequest()
            let sortDescription: NSSortDescriptor = NSSortDescriptor(keyPath: \Data.title, ascending: true)
            fetchRequest.sortDescriptors = [sortDescription]
            do {
                let data = try fetchRequest.execute()
                let originData = data[index]
                
                originData.title = title
                try context.save()
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
