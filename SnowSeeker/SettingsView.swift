//
//  SettingsView.swift
//  SnowSeeker
//
//  Created by Egor Gryadunov on 30.08.2021.
//

import SwiftUI


struct SettingsView: View
{
    @Environment(\.presentationMode) var presentationMode
    @Binding var sortedBy: ContentView.SortOptions
    @Binding var filtredBy: ContentView.FilterOptions
    
    @State private var country = ""
    @State private var size = 1
    @State private var price = 1
    
    @State private var sorted = 0
    @State private var filtred = 0
    
    private let sortedString = ["None", "By alphabet", "By country"]
    private let filtredString = ["None", "By country", "By size", "By price"]
        
    var body: some View {
        Form {
            Section {
                Text("Choose sorted type:")
                Picker("Sorted by:", selection: $sorted) {
                    ForEach(0..<3) { index in
                        Text("\(sortedString[index])")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            
            Section {
                Text("Choose filtred type:")
                Picker("Sorted by:", selection: $filtred) {
                    ForEach(0..<4) { index in
                        Text("\(filtredString[index])")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Group {
                    if filtred == 1 {
                        TextField("Country name", text: $country)
                    }
                    if filtred == 2 {
                        TextField("Size", text: $country)
                    }
                    if filtred == 3 {
                        TextField("Price", text: $country)
                    }
                }
            }
            
            Section {
                Button("Done") {
                    switch sorted {
                    case 0:
                        self.sortedBy = .default
                    case 1:
                        self.sortedBy = .alphabetical
                    default:
                        self.sortedBy = .country
                    }
                    
                    switch filtred {
                    case 0:
                        self.filtredBy = .none
                    case 1:
                        self.filtredBy = .country(self.country)
                    case 2:
                        self.filtredBy = .size(self.size)
                    default:
                        self.filtredBy = .price(self.price)
                    }
                    
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(sortedBy: .constant(.default), filtredBy: .constant(.none))
    }
}
