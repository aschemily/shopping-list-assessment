//
//  Item.swift
//  Shopping List Assessment
//
//  Created by Emily Asch on 2/11/22.
//

import Foundation

class Item: Codable{
    var name: String
    var isComplete: Bool
    
    init(name: String, isComplete: Bool = false){
        self.name = name
        self.isComplete = isComplete
    }
}

extension Item: Equatable{
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name && lhs.isComplete == rhs.isComplete
    }
    
    
}

