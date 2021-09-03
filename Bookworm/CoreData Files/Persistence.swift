//
//  Persistence.swift
//  Bookworm
//
//  Created by Egor Gryadunov on 07.08.2021.
//

import CoreData

struct PersistenceController
{
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer

    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let context = controller.container.viewContext
        
        for number in 0..<8 {
            let newBook = Book(context: context)
            newBook.title = "JoJo part \(number)"
            newBook.author = "Hirohiko Araki"
            newBook.rating = Int16(5)
            newBook.genre = "Mystery"
            newBook.review = ""
        }

        return controller
    }()
    
    func save() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Show some error here
            }
        }
    }

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Bookworm")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}
