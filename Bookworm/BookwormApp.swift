//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Egor Gryadunov on 03.08.2021.
//

import SwiftUI
import CoreData

@main
struct BookwormApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
