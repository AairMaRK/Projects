//
//  SettingsView.swift
//  TrainMultiplication
//
//  Created by Egor Gryadunov on 22.07.2021.
//

import SwiftUI

struct SettingsView: View
{
    @State private var start = 1
    @State private var end = 10
    @State private var quantity = 1
    
    @Binding private var isGame: Bool
    
    var model: TrainMultiplication
    private var quantities = [5, 10, 20, 0]
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Text("Fill data for train multiplication table")
                        .font(.title)
                        .fontWeight(.bold)
                    Section {
                        Text("Start Number is: ")
                        Stepper(value: $start, in: 1...9) { Text("\(start)") }
                    }
                    Section {
                        Text("End Number is: ")
                        Stepper(value: $end, in: 2...10) { Text("\(end)") }
                    }
                    Section {
                        Text("Quantity of quastions is: ")
                        Picker("Quantity", selection: $quantity) {
                            ForEach(0..<quantities.count) { index in
                                Text("\(quantities[index] == 0 ? "All" : String(quantities[index]))")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                .font(.headline)
                .navigationBarTitle(Text("Settings"))
                .foregroundColor(.blue)
                Button(action: {
                    withAnimation(.linear) {
                        isGame = true
                        print("\(quantity)-\(start)-\(end)")
                        TrainMultiplication.createGame(game: model, quantity: quantities[quantity], start: start, end: end)
                    }
                }, label: {
                    Text("Next")
                        .frame(width: 360, height: 40)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .font(.headline)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                })
            }
        }
    }
    
    init(game: TrainMultiplication, checker: Binding<Bool>) {
        model = game
        _isGame = checker
    }
}
