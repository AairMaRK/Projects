//
//  RoleView.swift
//  RoleIt
//
//  Created by Egor Gryadunov on 28.08.2021.
//

import SwiftUI

struct RoleView: View
{
    @EnvironmentObject var rolls: Rolls
    @State private var timeRemaining = 5
    @State private var inputNumber = 0
    @State private var isActive = false
    @State private var feedback = UINotificationFeedbackGenerator()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color.blue)
                    .frame(width: 300, height: 300)
                Text("\(self.inputNumber)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
            }
            
            Spacer()
            
            ZStack {
                Capsule()
                    .fill(Color.green)
                    .frame(width: 200, height: 100)
                Button("Roll") {
                    roll()
                }
                .foregroundColor(.white)
                .font(.title)
            }
        }
        .padding()
        .onReceive(timer) { time in
            guard self.isActive else { return }
            
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
                self.inputNumber = Int.random(in: 1...6)
            } else {
                isActive = false
                timeRemaining = 5
                rolls.append(Roll(value: self.inputNumber))
            }
        }
    }
    
    private func roll() {
        isActive = true
    }
}

struct RoleView_Previews: PreviewProvider {
    static var previews: some View {
        RoleView()
    }
}
