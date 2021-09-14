//
//  Card.swift
//  SetGame
//
//  Created by Egor Gryadunov on 14.09.2021.
//

import Foundation

struct Card : Equatable
{
    let quantity: Content
    let shape: Content
    let color: Content
    let fill: Content
    
    enum Content : Int, CaseIterable
    {
        case one = 1
        case two
        case three
    }
}
