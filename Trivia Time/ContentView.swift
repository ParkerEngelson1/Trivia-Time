//
//  ContentView.swift
//  Trivia Time
//
//  Created by Parker Engelson on 11/20/25.
//

import SwiftUI

struct ContentView: View {
    private var time = 200
    var body: some View {
        
        NavigationView {
            
            VStack {
                Text("Trivia Time") // title
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                NavigationLink("Play", destination: GameView()) // sends to PlayView
                NavigationLink("Instructions", destination: InstructionsView()) // button to access instructions
                Picker(selection: .constant(4), label: Text("Time")) { // time selection still to be updated
                    Text("30").tag(1)
                    Text("1:00").tag(2)
                    Text("1:30").tag(3)
                    Text("2:00").tag(4)
                        //might delete, considering shifting to a streak based game
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

