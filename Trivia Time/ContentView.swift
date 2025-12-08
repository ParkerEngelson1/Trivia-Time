//
//  ContentView.swift
//  Trivia Time
//
//  Created by Parker Engelson on 11/20/25.
//

import SwiftUI

struct ContentView: View {
    @State private var highScore: Int = 0 // gets highscore from GameView
    @State private var inGame: Bool = false //ChatGPT 1
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("BEAT BRAIN") // title
                    .font(Font.custom("Baskerville", size: 80))
                    .italic()
                    .bold()
                    .fontWeight(.bold)
                    .padding(.top, 40)
                HStack{ // allows me to shrink the emoji
                    Text("🎤") // displays emoji
                        .font(Font.custom("San Francisco", size: 100))
                        .fontWeight(.bold)
                    Text("\(highScore)") // displays players highcore
                        .font(Font.custom("San Francisco", size: 150))
                        .fontWeight(.bold)
                }
                .padding(.top, 20)
                Spacer()
                Spacer()                
                HStack{ // puts buttons side by side
                    NavigationLink("Play", destination: GameView(highScore: $highScore, inGame: $inGame), isActive: $inGame) // sends to game view
                        .font(.title2)
                    NavigationLink("Instructions", destination: InstructionsView()) // sends to instructions view
                        .font(.title2)
                } //ChatGPT: "Using swift, How should I send a user back to the starting view after answering a question incorrectly? for reference, the user starts in a ContentView then plays the quiz in GameView"
            }
            .buttonStyle(CustomButtonStyle()) // loads custom button style for each of the buttons
            .padding(.bottom, 100)
        }
    }
}

struct CustomButtonStyle: ButtonStyle { // buttons for navigation links
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 130, height: 30)
            .bold()
            .padding()
            .background(.black).opacity(configuration.isPressed ? 0.0 : 1.0)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    ContentView()
}

