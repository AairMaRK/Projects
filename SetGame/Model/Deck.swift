//
//  Deck.swift
//  SetGame
//
//  Created by Egor Gryadunov on 14.09.2021.
//

import Foundation

struct Deck
{
    private(set) var cards = [Card]()
    
    mutating func draw() -> Card? {
        cards.count > 0 ? cards.remove(at: Int.random(in: cards.indices)) : nil
    }
    
    init() {
        for quantity in Card.Content.allCases {
            for shape in Card.Content.allCases {
                for color in Card.Content.allCases {
                    for fill in Card.Content.allCases {
                        cards.append(Card(quantity: quantity, shape: shape, color: color, fill: fill))
                    }
                }
            }
        }
    }
}
