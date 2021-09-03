//
//  ContentView.swift
//  EasyHabit
//
//  Created by Egor Gryadunov on 28.07.2021.
//

import SwiftUI

struct ContentView: View
{
    @ObservedObject var habits = Habits()
    @State private var showAddHabit = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits.items) { item in
                    NavigationLink(destination: HabitView(habit: item)) {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.description)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("EasyHabit")
            .navigationBarItems(trailing:
                HStack(spacing: 25) {
                    EditButton()
                    Button(action: {
                        self.showAddHabit = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                })
            .sheet(isPresented: $showAddHabit, content: {
                AddView(habits: self.habits)
            })
        }
    }
    
    private func removeItems(at offsets: IndexSet) { habits.items.remove(atOffsets: offsets) }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
