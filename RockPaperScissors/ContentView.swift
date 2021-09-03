//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Egor Gryadunov on 18.07.2021.
//

import SwiftUI

struct ContentView: View
{
    @State private var appMove = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var playerMove = 1
    @State private var score = 0
    @State private var movesCount = 0
    @State private var alertMessege = ""
    @State private var showMessege = false
    
    private let moves = ["Rock", "Paper", "Scissors"]
    private let combinations = [0 : 2, 1 : 0, 2 : 1]

    private var taskChecker: Bool {
        switch shouldWin {
        case true:
            if let task = combinations[playerMove], task == appMove {
                score += 10
                return true
            } else {
                score -= 5
                return false
            }
        case false:
            if let task = combinations[playerMove], task != appMove {
                score += 10
                return true
            } else {
                score -= 5
                return false
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            VStack(spacing: 80) {
                VStack {
                    Text("App's move:")
                        .fontWeight(.black)
                    ZStack {
                        RoundedRectangle(cornerRadius: 14)
                            .foregroundColor(.white)
                            .frame(width: 110, height: 110)
                        ButtonImage(name: moves[appMove])
                    }
                    Text("I need to \(shouldWin ? "Win" : "Lose")")
                        .fontWeight(.black)
                    Text("Score: \(score)")
                        .font(.largeTitle)
                }
                .font(.title)
                .foregroundColor(.white)
                HStack(spacing: 25) {
                    ForEach(0..<3) { move in
                        Button(action: {
                            playerMove = move
                            playGame()
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 14)
                                    .foregroundColor(.white)
                                    .frame(width: 110, height: 110)
                                ButtonImage(name: moves[move])
                            }
                        }
                        .animation(.linear)
                    }
                
                }
                Spacer()
            }
        }
        .alert(isPresented: $showMessege) {
            Alert(title: Text("Attention"), message: Text(alertMessege), dismissButton: .default(Text("Continue")) {
                newRound()
            })
        }
    }
    
    private func playGame() {
        if movesCount < 10 {
            movesCount += 1
            if taskChecker == true {
                alertMessege = "Congratulations!!!!"
            } else {
                alertMessege = "You've got mistake"
            }
        } else if movesCount == 10 {
            movesCount += 1
            if taskChecker == true {
                alertMessege = "Congratulations!!!! Your score: \(score)"
            } else {
                alertMessege = "You've got a final mistake. Score : \(score)"
            }
        } else {
            alertMessege = "Game was ended"
        }
        showMessege = true
    }
    
    private func newRound() {
        if movesCount <= 10 {
            appMove = Int.random(in: 0..<3)
            shouldWin = Bool.random()
        }
    }
}

struct ButtonImage: View
{
    var name: String
    
    var body: some View {
        Image(name)
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
