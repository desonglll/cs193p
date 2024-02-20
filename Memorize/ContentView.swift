//
//  ContentView.swift
//  Memorize
//
//  Created by Mike Shinoda on 2024/2/20.
//

import SwiftUI

struct ContentView: View {
  //    let emojis: [String] = [
  //        "👻", "🎃", "🕷️", "🕸️", "😈", "🧙‍♂️", "🧛‍♂️", "🧟‍♂️", "🦇", "🦉", "🍬", "🍭", "🍫", "🔮", "🌙",
  //    ]
  let emojis: [String] = [
    "😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "😊", "😇",
    "🙂", "🙃", "😉", "😌", "😍", "😘", "😗", "😙", "😚", "😋",
    "😛", "😝", "😜", "🤪", "🤨", "🧐", "🤓", "😎", "🤩", "🥳",
    "😏", "😒", "😞", "😔", "😟", "😕", "🙁", "☹️", "😣", "😖",
    "😫", "😩", "🥺", "😢", "😭", "😤", "😠", "😡", "🤬", "🤯",
    "😳", "🥵", "🥶", "😱", "😨", "😰", "😥", "😓", "🤗", "🤔",
    "🤭", "🤫", "🤥", "😶", "😐", "😑", "😬", "🙄", "😯", "😦",
    "😧", "😮", "😲", "🥱", "😴", "🤤", "😪", "😵", "🤐", "🥴",
    "🤢", "🤮", "🤧", "😷", "🤒", "🤕", "🤑", "🤠", "😈", "👿",
    "👹", "👺", "🤡", "💩", "👻", "💀", "☠️", "👽", "👾", "🤖",
    "🎃", "😺", "😸", "😹", "😻", "😼", "😽", "🙀", "😿", "😾",
  ]

  @State var cardCount: Int = 4
  var body: some View {
    VStack {
      ScrollView {
        cards
      }
      Spacer()
      cardCountAdjusters
    }
    .padding()
  }
  var cards: some View {
    return LazyVGrid(columns: [GridItem(.adaptive(minimum: 120, maximum: 200))]) {  // implicit `return`
      ForEach(0..<cardCount, id: \.self) { index in  // This is the function argument.
        // `emojis.indices` returns the range of the emojis array.
        CardView(content: emojis[index])
          .aspectRatio(2 / 3, contentMode: .fit)  // for each card size of 3:2
      }
    }
    .foregroundColor(.orange)
  }

  var cardCountAdjusters: some View {
    HStack {
      cardRemover
      Spacer()
      cardAdder
    }
    .font(.largeTitle)
  }

  func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
    Button(
      action: {
        cardCount += offset
      },
      label: {
        Image(systemName: symbol)
      }
    )
    .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
  }

  var cardAdder: some View {
    return cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus")
  }

  var cardRemover: some View {
    return cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus")

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
  ContentView()
}
