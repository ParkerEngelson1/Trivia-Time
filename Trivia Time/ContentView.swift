//
//  ContentView.swift
//  Trivia Time
//
//  Created by Parker Engelson on 11/20/25.
//

import SwiftUI

struct ContentView: View {
    private var time = 200
    @State private var highScore: Int = 0 //highscore
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
                    Text("🎤") // displays highscore
                        .font(Font.custom("San Francisco", size: 100))
                        .fontWeight(.bold)
                    Text("\(highScore)")
                        .font(Font.custom("San Francisco", size: 150))
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .padding(.top, 20)
                Spacer()
                Spacer()
                HStack{ // puts buttons side by side
                    NavigationLink("Play", destination: GameView(highScore: $highScore)) // sends to GameView
                        .font(.title2)
                    NavigationLink("Instructions", destination: InstructionsView()) // button to access instructions
                        .font(.title2)
                }
                .buttonStyle(CustomButtonStyle())
                .padding(.bottom, 100)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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

