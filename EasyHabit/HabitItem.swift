//
//  HabitItem.swift
//  EasyHabit
//
//  Created by Egor Gryadunov on 28.07.2021.
//

import Foundation

struct HabitItem: Identifiable, Codable
{
    var id = UUID()
    var name: String
    var description: String
    var count: Int
}

class Habits: ObservableObject
{
    @Published var items = [HabitItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) { UserDefaults.standard.set(encoded, forKey: "Items") }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([HabitItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}
