import SwiftUI

struct GameView: View {
    
    @State private var questions: [String] = [] // question list
    @State private var currentQuestion: String = "" // question being shown
    @State private var result: String = ""
    var body: some View {
        VStack {
            Button("Load Questions") { // brings new question
                result = ""
                questions = loadQuestions() // load question onto new array
                if !questions.isEmpty { // Check to look for empty array
                    currentQuestion = questions.randomElement() ?? ""
                }
            }
            var printingString = String(currentQuestion.dropFirst())

            Text(printingString) // question
            Button("1") {
                if currentQuestion.first == "1" {
                    result = "Correct"
                }
            }
            Button("2") {
                if currentQuestion.first == "2" {
                    result = "Correct"
                }
            }
            Button("3") {
                if currentQuestion.first == "3" {
                    result = "Correct"
                }
            }
            Button("4") {
                if currentQuestion.first == "4" {
                    result = "Correct"
                }
            }
            Text(result)
            
        }
    }
}

func loadQuestions() -> [String] { // holds questions
    return ["1What Year is it? 1: 2025, 2: 2020, 3: 2019, 4: 2018", "2What state are we in? 1: Texas, 2: Illinois, 3: California, 4: New York", "3What is the capital of Texas? 1: Austin, 2: Houston, 3: Dallas, 4: San Antonio", "4What is the capital of California? 1: San Francisco, 2: Los Angeles, 3: San Diego, 4: Sacramento", "3Whats my name? 1: Alex, 2: Ben, 3: Parker, 4: David"]
}

#Preview {
    GameView()
}
