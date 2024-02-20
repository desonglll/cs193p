//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Mike Shinoda on 2024/2/20.
//

import Foundation

struct MemoryGame<CardContent>{
    var cards:Array<Card>
    
    func choose(card:Card){
        
    }
    
    struct Card{
        var isFaceUp:Bool
        var isMatched: Bool
        var content: CardContent
    }
}
