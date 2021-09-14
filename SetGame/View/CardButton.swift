//
//  CardButton.swift
//  SetGame
//
//  Created by Egor Gryadunov on 14.09.2021.
//

import UIKit

class CardButton: UIButton
{
    var card: Card? = Card(quantity: .two, shape: .one, color: .three, fill: .three) {
        didSet { updateButton() }
    }
    
    func setBackground(color: UIColor) {
        layer.backgroundColor = color.cgColor
    }

    private func getText(for card: Card) -> NSAttributedString {
        let shape = getContent(for: card)
        
        let attributes: [NSAttributedString.Key : Any] = [
            .strokeColor: Constants.colors[card.color.rawValue - 1],
            .strokeWidth: Constants.widths[card.fill.rawValue - 1],
            .foregroundColor: Constants.colors[card.color.rawValue - 1]
                .withAlphaComponent(Constants.alphas[card.fill.rawValue - 1])
        ]
        
        return NSAttributedString(string: shape, attributes: attributes)
    }
    
    private func getContent(for card: Card) -> String {
        let shape = Constants.shapes[card.shape.rawValue - 1]
        var content = ""
        
        for iter in 0..<card.quantity.rawValue {
            content += shape
            
            if iter != card.quantity.rawValue - 1 {
                content += "\n"
            }
        }
        
        return content
    }
    
    private func updateButton() {
        if let card = card {
            let attributedString = getText(for: card)
            setAttributedTitle(attributedString, for: .normal)
            isEnabled = true
        } else {
            setAttributedTitle(nil, for: .normal)
            isEnabled = false
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        titleLabel?.numberOfLines = 0
        layer.cornerRadius = 15
    }
    
    private struct Constants
    {
        static let colors = [#colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1), #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)]
        static let alphas: [CGFloat] = [1.0, 0.45, 0.2]
        static let widths: [CGFloat] = [-5, 5, -5]
        static let shapes = ["●", "▲", "■"]
    }
}
