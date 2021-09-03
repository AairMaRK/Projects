//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Egor Gryadunov on 29.08.2021.
//

import SwiftUI

struct ContentView: View
{
    @ObservedObject var favorites = Favorites()
    @State private var sortedBy = SortOptions.default
    @State private var filtredBy = FilterOptions.none
    @State private var showingSettingsView = false
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    var sortedResort: [Resort] {
        switch sortedBy {
        case .default:
            return resorts
        case .alphabetical:
            return resorts.sorted { $0.name < $1.name }
        case .country:
            return resorts.sorted { $0.country < $1.country }
        }
    }
    
    var filtredResorts: [Resort] {
        switch filtredBy {
        case .none:
            return sortedResort
        case .country(let place):
            return sortedResort.filter { $0.country == place }
        case .size(let size):
            return sortedResort.filter { $0.size == size }
        case .price(let price):
            return sortedResort.filter { $0.price == price }
        }
    }
    
    enum SortOptions: Int {
        case `default` = 1, alphabetical, country
    }
    
    enum FilterOptions {
        case none, country(String), size(Int), price(Int)
    }
    
    var body: some View {
        NavigationView {
            List(filtredResorts) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        
                        Text(" \(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    
                    if self.favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Resorts")
            .navigationBarItems(trailing: Button("Settings") {
                self.showingSettingsView = true
            })
            .sheet(isPresented: $showingSettingsView) {
                SettingsView(sortedBy: $sortedBy, filtredBy: $filtredBy)
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
