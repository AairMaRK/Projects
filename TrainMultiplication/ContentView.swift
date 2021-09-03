//
//  ContentView.swift
//  TrainMultiplication
//
//  Created by Egor Gryadunov on 21.07.2021.
//

import SwiftUI

struct ContentView: View
{
    @State private var isAGame = false
    private var model = TrainMultiplication()
    
    
    var body: some View {
        Group {
            if isAGame {
                GameView(model: model, isGame: $isAGame)
            } else {
                SettingsView(game: model, checker: $isAGame)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
