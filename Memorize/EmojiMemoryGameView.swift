//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Mike Shinoda on 2024/2/20.
//

import SwiftUI

struct EmojiMemoryGameView: View {
  var viewModel: EmojiMemoryGame
  let emojis: [String] = [
    "👻", "🎃", "🕷️", "🕸️", "😈", "🧙‍♂️", "🧛‍♂️", "🧟‍♂️", "🦇", "🦉", "🍬", "🍭", "🍫", "🔮", "🌙",
  ]

  @State var cardCount: Int = 4
  var body: some View {
    ScrollView {
      cards
    }
    .padding()

  }
  var cards: some View {
    return LazyVGrid(columns: [GridItem(.adaptive(minimum: 120, maximum: 200))]) {  // implicit `return`
      ForEach(emojis.indices, id: \.self) { index in  // This is the function argument.
        // `emojis.indices` returns the range of the emojis array.
        CardView(content: emojis[index])
          .aspectRatio(2 / 3, contentMode: .fit)  // for each card size of 3:2
      }
    }
    .foregroundColor(.orange)
  }
}

struct CardView: View {
  let content: String
  @State var isFaceUp: Bool = true
  var body: some View {
    ZStack(content: {
      let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
      Group {
        base.fill(.white)
        base
          .strokeBorder(lineWidth: 2)
        Text(content).font(.largeTitle)
      }
      .opacity(isFaceUp ? 1 : 0)
      base.fill().opacity(isFaceUp ? 0 : 1)
    }).onTapGesture(perform: {
      print("Tapped \(isFaceUp)")
      isFaceUp.toggle()  // Switch Bool value between true and false
    })
  }
}

#Preview {
  EmojiMemoryGameView()
}
