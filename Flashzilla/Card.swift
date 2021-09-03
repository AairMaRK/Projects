//
//  Card.swift
//  Flashzilla
//
//  Created by Egor Gryadunov on 26.08.2021.
//

import Foundation

struct Card: Codable, Identifiable
{
    var id = UUID()
    let prompt: String
    var answer: String
    
    static var example: Card {
        Card(prompt: "Who was the protagonist in JoJo: Battle Tendency?", answer: "Joseph Joestar")
    }
}
