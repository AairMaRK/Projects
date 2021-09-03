//
//  TrainMultiplication.swift
//  TrainMultiplication
//
//  Created by Egor Gryadunov on 21.07.2021.
//

import Foundation

class TrainMultiplication
{
    var quastions = [String]()
    var answers = [String]()
    
    func checkAnswer(answer: Int, for quastion: String) -> Bool {
        let strAnswer = String(answer)
        if let index = quastions.firstIndex(of: quastion) {
            guard answers[index] == strAnswer else { return false }
            return true
        } else {
            fatalError("Answer quastion didn't found")
        }
    }
    
    static func createGame(game: TrainMultiplication, quantity: Int, start: Int, end: Int) {
        var tables = [MultiplicationTable]()
        var quastionsQuantity = quantity+1
        var iter = 0
        for num in start...end { tables.append(MultiplicationTable(number: num)) }
        while quastionsQuantity > 1 {
            let tmpNum = Int.random(in: 0..<quastionsQuantity)
            for _ in 0..<tmpNum {
                let index = Int.random(in: 0..<tables[iter].quastions.count)
                let element = tables[iter].quastions.remove(at: index)
                game.quastions.append(element)
                game.answers.append(tables[iter].answers[index])
                tables[iter].answers.remove(at: index)
                print(element)
            }
            quastionsQuantity -= tmpNum
            iter += 1
        }
    }
}
