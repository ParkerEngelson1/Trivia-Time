import SwiftUI
struct GameView: View {
    private let questionBank = QuestionBank() // loads question bank
    @State private var currentQuestion: Question? // question being shown
    @State private var result: String = "" // place holder for correct or false
    @State private var streak: Int = 0 // streak
    @Binding var highScore: Int //Makes sure the highscorer is able to travel to Content and game view
    @Binding var inGame: Bool
    var body: some View {
        VStack {
            if let q = currentQuestion { // sends question
                Text(q.text) // displays the question text
                    .italic()
                    .fontWeight(.bold)
                    .position(x: 200, y: 100)
                    .font(.custom("Arial", size: 40))
                    .safeAreaPadding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }
            HStack{
                Text("🔥\(streak)")// Displays current streak
                Text(" ")
                Text("👑\(highScore)") // Displays highscore
            }
            .font(.custom("Arial", size: 80))
            .padding(40)
            Text(result) // true or false
            if let q = currentQuestion { // initializes question (always true)
                HStack { // Makes buttons into 2x2 grid
                    Button(q.answers[0]) { // First answer
                        if 0 == q.correctAnswerIndex { // checks for correct answer
                            result = "Correct" // returns correct
                            streak += 1 // adds to streak
                            if streak > highScore { // checks if streak is greater than the high score
                                highScore = streak // if the streak is greater than high score it updates
                            }
                        } else {
                            result = "False" // if incorrect returns false
                            streak = 0 // streak reset
                            inGame = false
                            return
                        }
                        DispatchQueue.main.asyncAfter(deadline:  .now() + 3)  { // waits 3 seconds
                            loadNewQuestion() // loads a new question
                        }
                    }
                    .buttonStyle(CustomButtonStyle()) // button style
                    Button(q.answers[1]) {
                        if 1 == q.correctAnswerIndex {
                            result = "Correct"
                            streak += 1
                            if streak > highScore {
                                highScore = streak
                            }
                        } else {
                            result = "False"
                            streak = 0
                            inGame = false // if incorrect changes inGame variable to false, then moving user to contentView
                            return
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            loadNewQuestion()
                        }
                    }
                    .buttonStyle(CustomButtonStyle())
                }
                HStack {
                    Button(q.answers[2]) {
                        if 2 == q.correctAnswerIndex {
                            result = "Correct"
                            streak += 1
                            if streak > highScore {
                                highScore = streak
                            }
                        } else {
                            result = "False"
                            streak = 0
                            inGame = false
                            return
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            loadNewQuestion()
                        }
                    }
                    .buttonStyle(CustomButtonStyle())
                    Button(q.answers[3]) {
                        if 3 == q.correctAnswerIndex {
                            result = "Correct"
                            streak += 1
                            if streak > highScore {
                                highScore = streak
                            }
                        } else {
                            result = "False"
                            streak = 0
                            inGame = false
                            return
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            loadNewQuestion()
                        }
                    }
                    .buttonStyle(CustomButtonStyle())
                }
            }
        }
        .onAppear { // allows question to immediately load
            loadNewQuestion()
        }
        Spacer()
    }
    
    func loadNewQuestion() { // helper method to load question bank into gameview
        currentQuestion = questionBank.randomQuestion() // initializes
        result = "" // sets result blank
    }
}

struct Question { // creates a question object when called with 3 parameters
    let text: String // question that is given
    let answers: [String] // array with correct answer + 3 decoy answers
    let correctAnswerIndex: Int // index of correct answer in the answers[] array
}

struct QuestionBank { //
    let questions: [Question] = [
        Question(text: "What year is it?", answers: ["2025", "2020", "2019", "2018"], correctAnswerIndex: 0),
        Question(text: "What state are we in?", answers: ["Texas", "Illinois", "California", "New York"], correctAnswerIndex: 1),
        Question(text: "What is the capital of Texas?", answers: ["Austin", "Houston", "Dallas", "San Antonio"], correctAnswerIndex: 0),
        Question(text: "What is the capital of California?", answers: ["San Francisco", "Los Angeles", "San Diego", "Sacramento"], correctAnswerIndex: 3),
        Question(text: "What's my name?", answers: ["Alex", "Ben", "Parker", "David"], correctAnswerIndex: 2)
    ] // questions array holding question objects
    
    func randomQuestion() -> Question { // method that calls a random integer in the questions array
        questions.randomElement()!
    }
}

struct CustomButtonStyle1: ButtonStyle { // buttons for answers
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
    GameView(highScore: .constant(0), inGame: .constant(true)) // ChatGPT1
}
