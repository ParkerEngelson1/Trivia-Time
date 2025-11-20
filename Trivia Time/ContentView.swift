//
//  ContentView.swift
//  Trivia Time
//
//  Created by Parker Engelson on 11/20/25.
//

import SwiftUI

struct ContentView: View {
    private var time = 1
    var body: some View {
        Text("Trivia Time")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding()
        NavigationView {
            
            VStack {
                
                
                NavigationLink("PLAY", destination: InstructionsView())
                Picker(selection: .constant(4), label: Text("Time")) {
                    Text("30").tag(1)
                    Text("1:00").tag(2)
                    Text("1:30").tag(3)
                    Text("2:00").tag(4)
                    
                        
                    
                }
            }
            
            
        }
        
    }
    
    
}
#Preview {
    ContentView()
}

