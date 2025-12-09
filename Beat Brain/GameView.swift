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
    @State private var strikesString: String = "" // amount of strikes, mutatable to add 💔 emojis
    @Binding var inGame: Bool // declares inGame as binding in order to be able to move from view to view
    @State private var remainingQuestions: [Question] = []
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
                    .padding(.trailing, 10)
                    .minimumScaleFactor(0.75) // scales the text down if needed
            }
            Text(result) // displays after the question is answered
                .textCase(.uppercase)
                .font(.largeTitle.bold())
                .foregroundColor(result == "Correct" ? .green : .red) // if the answer is correct then the text will be green, else will be red
                .animation(.easeOut(duration: 0.1), value: result) // fades out
            Text(strikesString) // displays the amount of strikes that a player has on screen
                .font(Font.custom("Arial", size: 50))
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
        Button
            { 
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
                strikesString += "💔" // adds broked heart to strikeString
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
        } label: {
            Text(question.answers[index])
                .font(.system(size: 20))   // base size
                .lineLimit(1)              // keep text to one line
                .minimumScaleFactor(0.50)  // shrinks text if it cant fit
                .allowsTightening(true)
                .frame(maxWidth: .infinity) // makes sure text can expand
        }
        .buttonStyle(CustomButtonStyle1()) // button style
    }
    
    func loadNewQuestion() { // helper method to load question bank into gameview
        if remainingQuestions.isEmpty { // if all questions are answered the array will be shuffled then re added to the pool
                   remainingQuestions = questionBank.questions.shuffled()
               }
        currentQuestion = remainingQuestions.removeFirst() // removes question
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
        Question(text: "Stefani Joanne Angelina Germanotta is the real name of which singer?", answers: ["Lady Gaga", "Katy Perry", "Sia", "Christina Aguilera"], correctAnswerIndex: 0),
        Question(text: "Before Miley Cyrus recorded 'Wrecking Ball,' it was offered to another singer. Who?", answers: ["Beyoncé", "Rihanna", "Kesha", "Adele"], correctAnswerIndex: 0),
        Question(text: "Madonna also known as the 'Queen of Pop' released her first top 10 hit with what song?", answers: ["Vogue", "Like a Virgin", "Material Girl", "Holiday"], correctAnswerIndex: 3),
        Question(text: "In The Big Lebowski, 'The Dude' can’t stand which band?", answers: ["The Rolling Stones", "The Doors", "The Eagles", "Queen"], correctAnswerIndex: 2),
        Question(text: "Who was the very first American Idol winner?", answers: ["Carrie Underwood", "Kelly Clarkson", "Fantasia Barrino", "Jordin Sparks"], correctAnswerIndex: 1),
        Question(text: "Before 'Bleachers' and 'fun.' Jack Antonoff fronted which band?", answers: ["The Killers", "Panic! At the Disco", "The Strokes", "Steel Train"], correctAnswerIndex: 3),
        Question(text: "This singer moonwalked across stages worldwide. Name him.", answers: ["Chris Brown", "Usher", "Michael Jackson", "Justin Timberlake"], correctAnswerIndex: 2),
        Question(text: "This duo sang the 1981 hit 'Endless Love'. Who are they?", answers: ["Simon & Garfunkel", "Marvin Gaye & Tammi Terrell", "John Lennon & Yoko Ono", "Lionel Richie & Diana Ross"], correctAnswerIndex: 3),
        Question(text: "Which rock band released the album 'Back in Black'?", answers: ["AC/DC", "Guns N’ Roses", "Metallica", "Def Leppard"], correctAnswerIndex: 0),
        Question(text: "This singer performed the theme for the 2012 Bond film 'Skyfall'.", answers: ["Sam Smith", "Adele", "Rihanna", "Billie Eilish"], correctAnswerIndex: 1),
        Question(text: "This artist wrote songs for Ariana Grande, Miley Cyrus, Britney Spears, and Alice Cooper. Who is it?", answers: ["Kesha", "Sia", "Dua Lipa", "Lady Gaga"], correctAnswerIndex: 0),
        Question(text: "Who sang 'I Want It That Way' in the late '90s?", answers: ["Take That", "NSYNC", "Boyz II Men", "Backstreet Boys"], correctAnswerIndex: 3),
        Question(text: "This University of Michigan Football tradition revolves around the singing of which 2000s rock song.", answers: ["Seven Nation Army", "The Middle", "Mr Brightside", "Beverly Hills"], correctAnswerIndex: 2),
        Question(text: "This rapper performed 'Lose Yourself'.", answers: ["Dr. Dre", "Eminem", "50 Cent", "Snoop Dogg"], correctAnswerIndex: 1),
        Question(text: "Who is known as the 'Queen of Soul'?", answers: ["Tina Turner", "Whitney Houston", "Aretha Franklin", "Gloria Gaynor"], correctAnswerIndex: 2),
        Question(text: "This singer released her biggest album yet titled 'Future Nostalgia' in 2020.", answers: ["Dua Lipa", "Charli XCX", "Sia", "Tove Lo"], correctAnswerIndex: 0),
        Question(text: "Which band’s 1973 album 'Dark Side of the Moon' became an instant classic?", answers: ["Led Zeppelin", "The Who", "Pink Floyd", "Queen"], correctAnswerIndex: 2),
        Question(text: "This rapper released 'SICKO MODE' in 2018. Who is he?", answers: ["J. Cole", "Drake", "Kendrick Lamar", "Travis Scott"], correctAnswerIndex: 3),
        Question(text: "'South Park' dad Randy Marsh lives a secret double life as this singer.", answers: ["Dua Lipa", "Billie Eilish", "Lorde", "Sia"], correctAnswerIndex: 2),
        Question(text: "Live AID 1985 Britain was held at Wembly, The American concert was held where?", answers: ["The Colliseum", "JFK Stadium", "The Astrodome", "Soldier Field"], correctAnswerIndex: 1),
        Question(text: "She sang 'drivers license' in 2021", answers: ["Olivia Rodrigo", "Billie Eilish", "Conan Gray", "Lorde"], correctAnswerIndex: 0),
        Question(text: "This British band released the album 'OK Computer'. in 1997", answers: ["Radiohead", "Coldplay", "Muse", "Blur"], correctAnswerIndex: 0),
        Question(text: "What was Freddie Mercury’s real name?", answers: ["Francis Bulsara", "Frederick Mercury", "Farid Mershad", "Farrokh Bulsara"], correctAnswerIndex: 3),
        Question(text: "Keith Moon and John Entwistle of 'The Who' inspired the name of which other classic rock band?", answers: ["The Doors", "Led Zeppelin", "The Rolling Stones", "Pink Floyd"], correctAnswerIndex: 1),
        Question(text: "Which jazz legend recorded 'Kind of Blue' in 1959?", answers: ["Miles Davis", "John Coltrane", "Charlie Parker", "Duke Ellington"], correctAnswerIndex: 0),
        Question(text: "This Indiana city birthed both Micheal Jackson & Rapper Freddie Gibbs", answers: ["Indianapolis", "South Bend", "Bloomington", "Gary"], correctAnswerIndex: 3),
        Question(text: "Celine Dion's smash hit 'My Heart Will' Go On was featured in which movie?", answers: ["Titanic", "Forest Gump", "Back to The Future", "Clueless"], correctAnswerIndex: 0),
    ] // questions array holding question objects
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
    GameView(highScore: .constant(0), inGame: .constant(true)) // moves variables
}

