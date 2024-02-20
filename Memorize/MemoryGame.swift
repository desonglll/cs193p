//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Mike Shinoda on 2024/2/20.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    init(numberOfPairsCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = [Card]()
        // Add numberOfPairsCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairsCards) {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
        cards.shuffle()  // Shuffle after finishing creat cards.
    }
    
    private(set) var cards: [Card]  // Looking this variable is allowed but set is not. -> access control
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter{index in cards[index].isFaceUp}.only
        }
        set {
            return cards.indices.forEach{cards[$0].isFaceUp = (newValue == $0)}
            
        }
    }
    
    mutating func choose(_ card: Card) {
        print("choose \(card)")
        if let chosenIndex = cards.firstIndex(where: {
            $0.id == card.id
        }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
        
    }
    
    mutating func shuffle() {
        cards.shuffle()
        //        print(cards)
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        //        static func == (lhs: Card, rhs:Card) -> Bool {
        //            return lhs.isFaceUp == rhs.isFaceUp &&
        //            lhs.isMatched == rhs.isMatched &&
        //            lhs.content == rhs.content
        //        }
        
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: String
        var debugDescription: String {
            return "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
    }
}

extension Array{
    var only: Element?{
        return count == 1 ? first : nil
    }
}
