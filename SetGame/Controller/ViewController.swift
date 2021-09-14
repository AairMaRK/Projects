//
//  ViewController.swift
//  SetGame
//
//  Created by Egor Gryadunov on 14.09.2021.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet var cardButtons: [CardButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var deckLabel: UILabel!
    @IBOutlet weak var dealButton: UIButton!
    
    var game = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
    }
    
    @IBAction private func touchCard(_ sender: CardButton) {
        if let index = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: index)
            updateViewFromModel()
        }
    }
    @IBAction func deal(_ sender: UIButton) {
        game.deal()
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        updateButtonsFromModel()
        
        deckLabel.text = "Deck: \(game.deckSize)"
        scoreLabel.text = "Score: \(game.score)"
        
        dealButton.isEnabled = game.cards.count < 24 || game.deckSize == 0 || game.matchingIndices.count != 0
        if dealButton.isEnabled {
            dealButton.layer.backgroundColor = UIColor.white.cgColor
        } else {
            dealButton.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    private func updateButtonsFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            
            if index < game.cards.count {
                let card = game.cards[index]
                button.card = card
                if game.selectedIndices.contains(index) && !game.missIndices.contains(index) && !game.matchingIndices.contains(index) {
                    button.setBackground(color: #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1))
                } else if game.missIndices.contains(index) {
                    button.setBackground(color: #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1))
                } else if game.matchingIndices.contains(index) {
                    button.setBackground(color: #colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1))
                } else {
                    button.setBackground(color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
                }
            } else {
                button.card = nil
                button.setBackground(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0))
            }
        }
    }
}

