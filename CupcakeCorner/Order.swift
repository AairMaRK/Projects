//
//  Order.swift
//  CupcakeCorner
//
//  Created by Egor Gryadunov on 02.08.2021.
//

import Foundation

class Order: ObservableObject, Codable
{
    enum CodingKeys: CodingKey { case info }
    
    @Published var info = OrderInfo()
    
    init() {  }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        info = try container.decode(OrderInfo.self, forKey: .info)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(info, forKey: .info)
    }
}

struct OrderInfo: Codable
{
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnebled = false {
        didSet {
            if specialRequestEnebled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if check(name) || check(streetAddress) || check(city) || check(zip) {
            return false
        }
        return true
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2
        cost += Double(type) / 2
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    
    func check(_ str: String) -> Bool {
        let spaceCount = str.reduce(0) { $1 == " " ? $0 + 1 : $0 }
        guard str.count == spaceCount || str.isEmpty else { return false }
        return true
    }
}
