//
//  AddView.swift
//  iExpense
//
//  Created by Egor Gryadunov on 22.07.2021.
//

import SwiftUI

struct AddView: View
{
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var expences: Expenses
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    @State private var showAlert = false
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new Expence")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expences.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    showAlert = true
                }
            })
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Incorrect data"), message: Text("Yout amount isn't number"), dismissButton: .default(Text("Ok")))
            })
        }
    }
}

