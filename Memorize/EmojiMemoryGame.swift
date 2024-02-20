//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Mike Shinoda on 2024/2/20.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojis = [
        "👻", "🎃", "🕷️", "🕸️", "😈", "🧙‍♂️", "🧛‍♂️", "🧟‍♂️", "🦇", "🦉", "🍬", "🍭", "🍫", "🔮", "🌙",
    ]
    
    static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsCards: 18) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⚡️"
            }
        }
    }
    
    // If this var chanegd, it will call `something changed!!!`
    @Published private var model = EmojiMemoryGame.createMemoryGame()
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    //MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
