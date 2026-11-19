//
//  ContentView.swift
//  BrainTrainRPS
//
//  Created by Kelsey Steven on 11/14/26.
//

import SwiftUI


struct BackgroundView: View {
    var body: some View {
        RadialGradient(stops: [
            .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
            .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
        ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
    }
}

struct PlayArea: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding([.top, .bottom], 15)
            .frame(maxWidth: .infinity)
            .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 20))
    }
}

extension View {
    func playAreaStyle() -> some View {
        modifier(PlayArea())
    }
}


struct ContentView: View {
    @State private var moves = ["🪨", "📄", "✂️"].shuffled()
    @State private var gameMove = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var userChoice = -1
    @State private var score = 0
    @State private var questionsAsked = 1
    @State private var lastResult = ""
    @State private var showingGameOver = false
    
    var totalQuestions = 10
    var imgSize: CGFloat = 75
    
    var questionText: String {
        let winOrLose = shouldWin ? "win" : "lose"
        return "Choose the correct option to \(winOrLose) the game"
    }
    
    var textForGameMove: String {
        let moveToTextMapping = ["🪨": "Rock",
                                 "📄": "Paper",
                                 "✂️": "Scissors"]
        let moveAsText = moves[gameMove]
        return moveToTextMapping[moveAsText] ?? "Unknown"
    }
        
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                Text("Brain Train: 🪨, 📄, ✂️")
                    .font(.largeTitle.weight(.bold))
                
                Spacer()
                
                VStack(spacing: 10) {
                    Text("Game's move:")
                        .font(.headline)
                    Text(moves[gameMove])
                        .font(.system(size: imgSize))
                    Text(textForGameMove)
                        .font(.headline.weight(.heavy))
                }
                .padding()
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                
                VStack(spacing: 15) {
                    Text(questionText)
                        .font(.headline)
                    ForEach(0..<3) { number in
                        Button {
                            moveTapped(number)
                        } label: {
                            Text(moves[number])
                                .font(.system(size: imgSize))
                        }
                    }
                }
                    .playAreaStyle()
                
                Spacer()
                Spacer()

                VStack {
                    if questionsAsked > 1 {
                        Text(lastResult)
                    }
                    Text("Current Score:")
                        .font(.headline.weight(.heavy))
                        .foregroundStyle(.secondary)
                    Text(String(score))
                }
                
                Spacer()
            }
            .padding()
        }
        .alert("Game Ended", isPresented: $showingGameOver) {
            Button("Start new game", action: resetGame)
        } message: {
            Text("Your score was \(score)/\(totalQuestions)")
        }
    }
                                
    func getAnswer() -> String {
        let moveInfo = ["🪨": ["✂️", "📄"],
                        "📄": ["🪨", "✂️"],
                        "✂️": ["📄", "🪨"]]
        let move = moves[gameMove]
        let answer = shouldWin ? moveInfo[move]?[1] : moveInfo[move]?[0]
        return answer ?? "Unknown"
    }
    
    func moveTapped(_ number: Int) {
        userChoice = number
        let userAnswer = moves[userChoice]
        let answer = getAnswer()
        
        if userAnswer == answer {
            score += 1
            lastResult = "Correct!"
        } else {
            lastResult = "Wrong, the answer was: \(answer)"
        }
        
        if questionsAsked == totalQuestions {
            showingGameOver = true
        } else {
            askQuestion()
        }
    }
    
    func askQuestion() {
        moves.shuffle()
        gameMove = Int.random(in: 0...2)
        shouldWin = Bool.random()
        questionsAsked += 1
    }
    
    func resetGame() {
        userChoice = -1
        score = 0
        questionsAsked = 1
        lastResult = ""
        askQuestion()
        
        showingGameOver = false
    }
}

#Preview {
    ContentView()
}
