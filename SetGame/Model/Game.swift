//
//  Game.swift
//  SetGame
//
//  Created by Egor Gryadunov on 14.09.2021.
//

import Foundation

struct Game
{
    private(set) var cards = [Card]()
    private(set) var score = 0
    
    private(set) var selectedIndices = [Int]()
    private(set) var matchingIndices = [Int]()
    private(set) var missIndices = [Int]()
    
    private var deck = Deck()
    var deckSize: Int { deck.cards.count }

    mutating func chooseCard(at index: Int) {
        if !selectedIndices.contains(index) {
            selectedIndices.append(index)
            
            if selectedIndices.count == 3 {
                let tryingCards = selectedIndices.map { cards[$0] }
                
                if setTest(test: tryingCards) {
                    matchingIndices = selectedIndices
                    score += 10
                } else {
                    missIndices = selectedIndices
                    score -= 5
                }
            }
            
            if selectedIndices.count == 4 {
                updateCards()
            }
        } else if selectedIndices.count < 3 {
            if let ind = selectedIndices.firstIndex(of: index) {
                selectedIndices.remove(at: ind)
            }
        }
    }
    
    mutating func deal() {
        let dealCards = takeCards()
        if matchingIndices.count != 0 {
            cards.replace(elements: matchingIndices.map { cards[$0] }, to: dealCards)
            clearTurn()
            selectedIndices.removeAll()
        } else {
            cards += dealCards
        }
    }
    
    private mutating func takeCards() -> [Card] {
        var dealCards = [Card]()
        
        for _ in 0..<3 {
            if let card = deck.draw() {
                dealCards.append(card)
            }
        }
        
       return dealCards
    }
    
    private mutating func updateCards() {
        if matchingIndices.count != 0 {
            let elements = matchingIndices.map { cards[$0] }
            
            if cards.count > 12 {
                cards.remove(elements: elements)
            } else {
                let dealCards = takeCards()
                cards.replace(elements: elements, to: dealCards)
            }
        }
        
        clearTurn()
    }
    
    private mutating func clearTurn() {
        let last = selectedIndices.last!
        
        selectedIndices.removeAll()
        selectedIndices.append(last)
        matchingIndices.removeAll()
        missIndices.removeAll()
    }
    
    private func setTest(test: [Card]) -> Bool {
        guard test.count == 3 else { return false }
        let testingSum = [
            test.reduce(0, { $0 + $1.quantity.rawValue }),
            test.reduce(0, { $0 + $1.shape.rawValue }),
            test.reduce(0, { $0 + $1.color.rawValue }),
            test.reduce(0, { $0 + $1.fill.rawValue })
        ]
        return testingSum.reduce(true, { $0 && ($1 % 3 == 0) })
    }
    
    init() {
        for _ in 0..<12 {
            if let card = deck.draw() {
                cards.append(card)
            }
        }
    }
}
