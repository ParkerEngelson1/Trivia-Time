//
//  ContentView.swift
//  Trivia Time
//
//  Created by Parker Engelson on 11/20/25.
//

import SwiftUI

struct ContentView: View {
    private var time = 200
    @State private var highScore: Int = 0 //highscore declaration
    var body: some View {
        NavigationView {
            VStack {
                Text("Trivia Time") // title
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Text("\(highScore)") // displays highscore
                NavigationLink("Play", destination: GameView(highScore: $highScore)) // sends to GameView
                NavigationLink("Instructions", destination: InstructionsView()) // button to access instructions
                
            }
        }
    }
}
#Preview {
    ContentView()
}

