//
//  Array+Equatable.swift
//  SetGame
//
//  Created by Egor Gryadunov on 14.09.2021.
//

import Foundation

extension Array where Element: Equatable
{
    mutating func replace(elements: [Element], to newElements: [Element]) {
        guard elements.count == newElements.count else { return }
        
        for index in newElements.indices {
            if let matchingIndex = self.firstIndex(of: elements[index]) {
                self[matchingIndex] = newElements[index]
            }
        }
    }
    
    mutating func remove(elements: [Element]) {
        self = self.filter { !elements.contains($0) }
    }
}
