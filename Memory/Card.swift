//
//  Card.swift
//  Memory
//
//  Created by Nada Dawoud on 5/30/18.
//  Copyright © 2018 Mobile Apps Kitchen. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    var hashValue: Int {return identifier}
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    var seen = 0
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
