//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Mike Shinoda on 2024/2/20.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
