//
//  InstructionsView.swift
//  Trivia Time
//
//  Created by Parker Engelson on 12/2/25.
//

import SwiftUI

struct InstructionsView: View {
    var body: some View {
            Text("Press play to begin! Answer these fun music trivia questions! But be careful 3 strikes and you're done!")
                .font(Font.custom("Arial", size: 43))
                .italic()
                .bold()
                .fontWeight(.bold)
                .safeAreaPadding(20)
                .padding(.bottom, 60)
        Text("Version: 1.0")
            .padding()
            .font(Font.custom("Arial", size: 30))
        NavigationLink("Credits", destination: CreditsView())
            .foregroundColor(.white)
    }
}

#Preview {
    InstructionsView()
}
