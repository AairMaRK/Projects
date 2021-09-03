//
//  HabitView.swift
//  EasyHabit
//
//  Created by Egor Gryadunov on 28.07.2021.
//

import SwiftUI

struct HabitView: View
{
    private var habit: HabitItem
    @State private var count = 0
    
    var color: Color {
        switch count {
        case 0: return .black
        case 1...3: return .blue
        case 4...7: return .yellow
        case 8...14: return .orange
        case 15...20: return .purple
        default: return .green
        }
    }
    
    var body: some View {
        ZStack {
            color.edgesIgnoringSafeArea(.all)
            RoundedRectangle(cornerRadius: 10)
                .padding()
                .foregroundColor(.white)
            VStack(spacing: 25) {
                Spacer()
                Text("\(habit.name)")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundColor(color)
                Text(habit.description)
                    .foregroundColor(.gray)
                Text("Count: \(count)")
                    .foregroundColor(.red)
                Spacer()
                Button(action: {
                    count += 1
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.red, lineWidth: 2)
                            .frame(width: 150, height: 50)
                        Text("I'm do it today")
                            .foregroundColor(.red)
                            .font(.headline)
                    }
                    .padding()
                })
            }
            .padding()
        }
    }
    
    init(habit: HabitItem) {
        self.habit = habit
        count = Int(habit.count)
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        
        HabitView(habit: HabitItem(name: "Workout", description: "I'm pretty well", count: 0))
    }
}
