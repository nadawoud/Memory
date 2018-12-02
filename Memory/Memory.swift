//
//  Memory.swift
//  Memory
//
//  Created by Nada Dawoud on 5/30/18.
//  Copyright © 2018 Mobile Apps Kitchen. All rights reserved.
//

import Foundation
class Memory {
    
    var cards = [Card]()
    
    private(set) var score = 0
    
    private(set) var flipCount = 0
    
    private var indexOfOnlyFaceUpCard: Int? {
        get {
            var faceUpIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if faceUpIndex == nil {
                        faceUpIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return faceUpIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    init (numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards = shuffleCards()
    }
    
    func chooseCard(at index: Int) {
        flipCount += 1
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    if cards[index].seen > 1 || cards[indexOfOnlyFaceUpCard!].seen > 1 {
                        score -= 1
                    }
                }
                cards[index].seen += 1
                cards[index].isFaceUp = true
            }
            else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                indexOfOnlyFaceUpCard = index
                cards[index].seen += 1
            }
        }
    }
    
    func shuffleCards() -> [Card] {
        var shuffledCards = [Card]()
        for _ in cards.indices {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            shuffledCards.append(cards[randomIndex])
            cards.remove(at: randomIndex)
        }
        return shuffledCards
    }
    
    func reset() {
        flipCount = 0
        score = 0
        cards = shuffleCards()
        indexOfOnlyFaceUpCard = nil
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }
}
