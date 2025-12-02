import SwiftUI

struct GameView: View {
    private let questionBank = QuestionBank() // loads question bank
    @State private var currentQuestion: Question? // question being shown
    @State private var result: String = "" // place holder for correct or false
    @State private var streak: Int = 0 // streak
    @Binding var highScore: Int // Makes sure the highscore is able to travel to Content and game view
    @State private var waiting: Bool = false // when true it disables the buttons preventing the user from over loading the system with answers
    @State private var animateStreak = false // declaration of bool for telling when to animate
    @State private var strikes: Int = 0 // variable to track the amount of strikes
    @State private var strikeString: String = "" // amount of strikes, mutatable to add 💔 emojis
    @Binding var inGame: Bool // declares inGame as binding in order to be able to move from view to view
    var body: some View {
        VStack {
            if let q = currentQuestion { // loads current question as string q for
                Text(q.text) // displays the question text
                    .italic()
                    .fontWeight(.bold)
                    .position(x: 200, y: 100)
                    .font(.custom("Arial", size: 40))
                    .safeAreaPadding(10)
                    .multilineTextAlignment(.leading)
            }
            Text(result) // displays after the question is answered
                .textCase(.uppercase)
                .font(.largeTitle.bold())
                .foregroundColor(result == "Correct" ? .green : .red) // if the answer is correct then the text will be green, else will be red
                .animation(.easeOut(duration: 0.1), value: result) // fades out
            Text(strikeString) // displays the amount of strikes that a player has on screen
                .font(Font.custom("Arial", size: 60))
            HStack { // streak and highscore line
                Text("🔥\(streak)") // Displays current streak
                Text(" ")
                Text("🎵").font(.custom("Arial", size: 70))
                Text("\(highScore)") // Displays highscore
            }
            .font(.custom("Arial", size: 80))
            .scaleEffect(animateStreak ? 1.4 : 1.0) // this and line below are part of the animation after question is answered
            .animation(.easeOut(duration: 0.2), value: animateStreak)
            .position(x: 200, y: 150)
        }
        VStack {
            if let q = currentQuestion { // initializes question (always true)
                HStack { // Line one of grid
                    if waiting == false {
                        answerButton(index: 0, question: q) // button 1
                        answerButton(index: 1, question: q) // button 2
                    }
                }
                HStack { // Line two of grid
                    if waiting == false {
                        answerButton(index: 2, question: q) // button 3
                        answerButton(index: 3, question: q) // button 4
                    }
                }
            }
        }
        .safeAreaPadding(.bottom, 40)
        .onAppear { // allows question to immediately load after opening the view
            loadNewQuestion()
        }
        Spacer()
    }
    
    func answerButton(index: Int, question: Question) -> some View { // makes my code much more simple by removing the need for 4 different buttons
        Button(question.answers[index]) { // makes button
            if index == question.correctAnswerIndex { // checks for correct answer
                result = "Correct" // returns correct
                streak += 1 // adds to streak
                animateStreak = true // commands the animation of the streak and highscore to animate if correct
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    animateStreak = false // ends animation
                }
                if streak > highScore { // checks if streak is greater than the high score
                    highScore = streak // if the streak is greater than high score it updates
                }
            } else {
                strikes += 1 // adds a strike
                strikeString += "💔" // adds broked heart to strikeString
                if strikes == 3 { // if you have 3 strikes then instead of "False", "Game over" will be shown
                    result = "Game Over"
                } else {
                    result = "False"
                }
                // if incorrect returns false
                streak = 0 // streak reset
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    if strikes == 3 {
                        inGame = false // if incorrect changes inGame variable to false, then moving user to contentView
                        return // ends immediately
                    }
                }
            }
            waiting = true // disables buttons
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) { // waits 3 seconds
                loadNewQuestion() // loads a new question
                waiting = false // reactivates button
            }
        }
        .buttonStyle(CustomButtonStyle1()) // button style
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

struct QuestionBank { // holds question array for easy access
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
    GameView(highScore: .constant(0), inGame: .constant(true))
}

