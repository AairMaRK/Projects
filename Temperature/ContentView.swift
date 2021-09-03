//
//  ContentView.swift
//  Temperature
//
//  Created by Egor Gryadunov on 16.07.2021.
//

import SwiftUI

struct ContentView: View
{
    @State private var userTemperature = ""
    @State private var initialScale = 1
    @State private var outputScale = 1
    
    private let scales = [0 : "°C", 1 : "°F", 2 : "°K"]
    
    private var convertedValue: Double? {
        switch initialScale {
        case 0: return convertCelsius(userTemperature, to: outputScale)
        case 1: return convertFahrenheit(userTemperature, to: outputScale)
        case 2: return convertKelvin(userTemperature, to: outputScale)
        default: return nil
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Temperature", text: $userTemperature)
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("What's your scale?")) {
                    Picker("Initial Scale", selection: $initialScale) {
                        ForEach(0..<scales.count) { Text("\(scales[$0] ?? "")") }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("In what scale?")) {
                    Picker("Output Scale", selection: $outputScale) {
                        ForEach(0..<scales.count) { Text("\(scales[$0] ?? "")") }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Converted Temperature")) {
                    Text("\(convertedValue ?? 0.0, specifier: "%.2f")\(scales[outputScale] ?? "")")
                }
            }
            .navigationBarTitle("T°Converter")
        }
    }
    
    private func convertCelsius(_ degrees: String, to scale: Int) -> Double? {
        switch scale {
        case 0: return Double(degrees)
        case 1:
            guard let tmp = Double(degrees) else { return nil }
            return (tmp * 1.8) + 32.0
        case 2:
            guard let tmp = Double(degrees) else { return nil }
            return tmp + 273.15
        default: return nil
        }
    }
    
    private func convertFahrenheit(_ degrees: String, to scale: Int) -> Double? {
        switch scale {
        case 0:
            guard let tmp = Double(degrees) else { return nil }
            return (tmp - 32.0) / 1.8
        case 1: return Double(degrees)
        case 2:
            guard let tmp = Double(degrees) else { return nil }
            return (tmp + 459.67) / 1.8
        default: return nil
        }
    }

    private func convertKelvin(_ degrees: String, to scale: Int) -> Double? {
        switch scale {
        case 0:
            guard let tmp = Double(degrees) else { return nil }
            return tmp - 273.15
        case 1:
            guard let tmp = Double(degrees) else { return nil }
            return (tmp * 1.8) - 459.67
        case 2: return Double(degrees)
        default: return nil
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
