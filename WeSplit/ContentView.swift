//
//  ContentView.swift
//  WeSplit
//
//  Created by Egor Gryadunov on 14.07.2021.
//

import SwiftUI

struct ContentView: View
{
    @State
    private var checkAmount = ""
    @State
    private var numberOfPeople = ""
    @State
    private var tipPercentage = 2
    
    private let tipPercentages = [10, 15, 20, 25, 0]
    
    private var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 0
        let amountPerPerson = totalAmount / peopleCount
        return amountPerPerson.isNaN || amountPerPerson.isInfinite ? 0 : amountPerPerson
    }
    
    private var totalAmount: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        return orderAmount + tipValue
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("How muck tip dp you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) { Text("\(tipPercentages[$0])%") }
                        
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Total Amount")) {
                    Text("$\(totalAmount, specifier: "%.2f")")
                        .foregroundColor(tipPercentage == 4 ? .red : .blue)
                }
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
