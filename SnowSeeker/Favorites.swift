//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Egor Gryadunov on 30.08.2021.
//

import SwiftUI

class Favorites: ObservableObject
{
    private var resorts: Set<String>
    
    private let saveKey = "Favorites"
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    private func save() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent(saveKey)
            let data = try JSONEncoder().encode(self.resorts)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unabled to save data")
        }
    }
    
    private func loadData() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent(saveKey)
            let data = try Data(contentsOf: filename)
            resorts = try JSONDecoder().decode(Set<String>.self, from: data)
        } catch {
            print("Unabled to load saved data, \(error.localizedDescription)")
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    init() {
        self.resorts = []
        loadData()
    }
}
