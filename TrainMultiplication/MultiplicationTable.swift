//
//  MultiplicationTable.swift
//  TrainMultiplication
//
//  Created by Egor Gryadunov on 21.07.2021.
//

import Foundation

struct MultiplicationTable
{
    var number: Int
    var quastions = [String]()
    var answers = [String]()
    
    init(number: Int) {
        self.number = number
        for num in 1...10 {
            quastions.append("\(number)x\(num)=")
            answers.append("\(number*num)")
        }
    }
}
