//
//  Rolls.swift
//  RoleIt
//
//  Created by Egor Gryadunov on 28.08.2021.
//

import Foundation

struct Roll: Identifiable
{
    let id = UUID()
    var value: Int
}

class Rolls: ObservableObject
{
    @Published var all = [Roll]()
    
    func append(_ roll: Roll) {
        all.append(roll)
    }
}
