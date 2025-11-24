import SwiftUI

struct GameView: View {
    
    @State private var questions: [String] = [] // question list
    @State private var currentQuestion: String = "" // question being shown
    @State private var result: String = "" // place holder for correct or false
    
    @State private var streak: Int = 0
    @Binding var highScore: Int //Makes sure the highscorer is able to travel to Content and game view
    var body: some View {
        VStack {
            Text(String(currentQuestion.dropFirst())) // question to be displayed
            HStack { // Makes buttons into 2x2 grid
                Button("1") {
                    if currentQuestion.first == "1" {
                        result = "Correct"
                        streak += 1
                        if streak > highScore {
                            highScore = streak
                        }
                    } else {
                        result = "False"
                        streak = 0
                    }
                    loadNewQuestion()
                }
                .buttonStyle(CustomButtonStyle())
                Button("2") {
                    if currentQuestion.first == "2" {
                        result = "Correct"
                        streak += 1
                        if streak > highScore {
                            highScore = streak
                        }
                    } else {
                        result = "False"
                        streak = 0
                    }
                    loadNewQuestion()
                }
                
            }
            .buttonStyle(CustomButtonStyle())
            HStack {
                Button("3") {
                    if currentQuestion.first == "3" {
                        result = "Correct"
                        streak += 1
                        if streak > highScore {
                            highScore = streak
                        }
                    } else {
                        result = "False"
                        streak = 0
                    }
                    loadNewQuestion()
                }
                .buttonStyle(CustomButtonStyle())
               
                
                Button("4") {
                    if currentQuestion.first == "4" { //checks if question is correct, then adds to streak
                        result = "Correct"
                        streak += 1
                        if streak > highScore {
                            highScore = streak
                        }
                    } else {
                        result = "False"
                        streak = 0
                    }
                    loadNewQuestion()
                }
            }
            .buttonStyle(CustomButtonStyle())
            Text(result)
            Text("🔥\(streak)")// Displays current streak
            Text("👑\(highScore)") // Displays highscore
        }
        .onAppear { // allows question to immediately load
            loadNewQuestion()
        }
    }
    
    func loadNewQuestion() { // helper function for convenience
        result = ""
        questions = loadQuestions()
        if !questions.isEmpty {
            currentQuestion = questions.randomElement() ?? ""
        }
        
    }
}

func loadQuestions() -> [String] { // holds questions
    return ["1What Year is it? 1: 2025, 2: 2020, 3: 2019, 4: 2018", "2What state are we in? 1: Texas, 2: Illinois, 3: California, 4: New York", "3What is the capital of Texas? 1: Austin, 2: Houston, 3: Dallas, 4: San Antonio", "4What is the capital of California? 1: San Francisco, 2: Los Angeles, 3: San Diego, 4: Sacramento", "3Whats my name? 1: Alex, 2: Ben, 3: Parker, 4: David"]
}
struct CustomButtonStyle1: ButtonStyle { // buttons for navigation links
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
    GameView(highScore: .constant(0)) // sends to content view and starts at 0
}
