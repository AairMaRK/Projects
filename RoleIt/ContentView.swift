//
//  ContentView.swift
//  RoleIt
//
//  Created by Egor Gryadunov on 28.08.2021.
//

import SwiftUI

struct ContentView: View
{
    var rolls = Rolls()
    
    var body: some View {
        TabView {
            RoleView()
                .tabItem {
                    Image(systemName: "die.face.6.fill")
                    Text("Role")
                }
            
            HistoryView()
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("History")
                }
        }
        .environmentObject(rolls)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
