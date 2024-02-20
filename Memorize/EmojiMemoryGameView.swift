//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Mike Shinoda on 2024/2/20.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    // Or
    // @StateObject var viewModel: EmojiMemoryGame = EmojiMemoryGame()
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
        .padding()
        
    }
    var cards: some View {
        return LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {  // implicit `return`
            ForEach(viewModel.cards.indices, id: \.self) { index in  // This is the function argument.
                // `emojis.indices` returns the range of the emojis array.
                CardView(viewModel.cards[index])
                    .aspectRatio(2 / 3, contentMode: .fit)  // for each card size of 3:2
                    .padding(4)
            }
        }
        .foregroundColor(.orange)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    var body: some View {
        ZStack(content: {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base
                    .strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        })
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
