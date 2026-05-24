//
//  CoreDataStack.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/23/26.
//

import CoreData

final class CoreDataStack {
    static let shared = CoreDataStack()
    
    let container: NSPersistentContainer
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    private init() {
        container = NSPersistentContainer(name: "movie_data")
        
        container.loadPersistentStores { _, error in
            if let error {
                fatalError(error.localizedDescription)
            }
        }
        
        context.automaticallyMergesChangesFromParent = true
    }
}
