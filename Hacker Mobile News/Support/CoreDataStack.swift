//
//  CoreDataStack.swift
//  Hacker Mobile News
//
//  Created by Mario Elorza on 10-05-21.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Hacker_Mobile_News")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support

    func saveContext () {
        let context = CoreDataStack.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
