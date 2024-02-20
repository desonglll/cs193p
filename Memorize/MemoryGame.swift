//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Mike Shinoda on 2024/2/20.
//

import Foundation

struct MemoryGame<CardContent> {
    init(numberOfPairsCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = [Card]()
        // Add numberOfPairsCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairsCards) {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        cards.shuffle()  // Shuffle after finishing creat cards.
    }
    
    private(set) var cards: [Card]  // Looking this variable is allowed but set is not. -> access control
    
    func choose(_ card: Card) {
        
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    struct Card {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
    }
}
