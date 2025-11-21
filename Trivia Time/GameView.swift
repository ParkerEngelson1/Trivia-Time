import SwiftUI

struct GameView: View {
    @State private var questions: [String] = [] // question list
    
    var body: some View {
        VStack {
            //Text((questions[1]))
            
            Button("Load Questions") { // accesses question list
                loadQuestions()
            }
        }
    }
    
    func loadQuestions() { // holds questions
        questions.append("What is your name?")
        questions.append("What is your name? 1")
    }
}

#Preview {
    GameView()
}
