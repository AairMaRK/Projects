//
//  AddView.swift
//  EasyHabit
//
//  Created by Egor Gryadunov on 28.07.2021.
//

import SwiftUI

struct AddView: View
{
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var habits: Habits
    @State private var name = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Description", text: $description)
            }
            .navigationBarTitle("Add new Habit")
            .navigationBarItems(trailing: Button("Save") {
                let item = HabitItem(name: self.name, description: self.description, count: 0)
                self.habits.items.append(item)
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
