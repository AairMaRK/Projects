//
//  GameView.swift
//  TrainMultiplication
//
//  Created by Egor Gryadunov on 22.07.2021.
//

import SwiftUI

struct GameView: View
{
    @State private var currentQuestion = 0
    @State private var answer = ""
    @State private var isTrue: Bool? = nil
    @State private var correctAnswers = 0
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @Binding private var isGame: Bool
    
    var model: TrainMultiplication
    
    var body: some View {
        ZStack {
            if isTrue == nil {
                Color.blue.edgesIgnoringSafeArea(.all)
            } else if isTrue! {
                Color.green.edgesIgnoringSafeArea(.all)
            } else {
                Color.red.edgesIgnoringSafeArea(.all)
            }
            VStack(spacing: 20) {
                Text("Train Multiplication")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 360, height: 100)
                        .foregroundColor(.white)
                    Text("\(model.quastions[currentQuestion])")
                        .font(.title)
                        .foregroundColor(.black)
                        .fontWeight(.light)
                }
                TextField("Answer", text: $answer)
                    .frame(width: 330, height: 70)
                    .foregroundColor(.black)
                    .font(.headline)
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                Spacer()
                Button(action: {
                    withAnimation(.easeIn) {
                        checkAnswer(answer: answer, for: model.quastions[currentQuestion])
                    }
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 330, height: 100)
                            .foregroundColor(.gray)
                        Text("Check answer")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                    }
                })
            }
        }.alert(isPresented: $showAlert, content: {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Next")) {
                if currentQuestion == model.quastions.count-1 {
                    withAnimation(.linear) {
                        newGame()
                    }
                } else {
                    currentQuestion += 1
                    isTrue = nil
                }
                
            })
        })
    }
    
    private func checkAnswer(answer: String, for quastion: String) {
        let intAnswer = Int(answer) ?? -1
        guard intAnswer != -1 else { fatalError("User input isn't integer") }
        if model.checkAnswer(answer: intAnswer, for: quastion) {
            isTrue = true
            correctAnswers += 1
        } else {
            isTrue = false
        }
        if currentQuestion < model.quastions.count-1 {
            alertTitle = "And it is..."
            alertMessage = "\(isTrue! ? "Correct" : "Wrong")"
            showAlert = true
        } else if currentQuestion == model.quastions.count-1 {
            alertTitle = "Your Result:"
            alertMessage = "CorrectAnswers is: \(correctAnswers)"
            showAlert = true
        }
        self.answer = ""
    }
    
    private func newGame() {
        isGame = false
        currentQuestion = 0
        correctAnswers = 0
        answer = ""
    }
    
    init(model: TrainMultiplication, isGame: Binding<Bool>) {
        self.model = model
        self._isGame = isGame
    }
}
