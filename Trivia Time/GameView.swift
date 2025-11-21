import SwiftUI

struct GameView: View {
    
    @State private var questions: [String] = [] // question list
    @State private var currentQuestion: String = "" // question being shown
    
    var body: some View {
        VStack {
            Button("Load Questions") { // brings new question
                questions = loadQuestions() // load question onto new array
                if !questions.isEmpty { // Check to look for empty array
                    currentQuestion = questions.randomElement() ?? ""
                }
            }
            Text(currentQuestion) // question
        }
    }
}

func loadQuestions() -> [String] { // holds questions
    return ["yes", "no"]
}

#Preview {
    GameView()
}
