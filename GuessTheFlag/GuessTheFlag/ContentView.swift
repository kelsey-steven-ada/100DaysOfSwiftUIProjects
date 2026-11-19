//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kelsey Steven on 11/13/26.
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

struct FlagImage: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .clipShape(.rect(cornerRadius: 20))
            .shadow(radius: 5)
    }
}

struct PlayArea: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
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
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var answer = Int.random(in: 0...2)
    @State private var userChoice = -1
    @State private var showingScore = false
    @State private var showingGameOver = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var questionsAsked = 1
    
    let totalQuestions = 8
    
    var correction: String {
        let country = countries[userChoice]
        return "You chose the flag of \(country)"
    }
    
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                Text("Guess the flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.headline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[answer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    VStack(spacing: 30) {
                        ForEach(0..<3) { number in
                            Button {
                                flagTapped(number)
                            } label: {
                                FlagImage(imageName: countries[number])
                            }
                        }
                    }
                        .padding(.top, 15)
                }
                    .playAreaStyle()
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            VStack{
                if scoreTitle == "Wrong" {
                    Text(correction)
                }
                Text("Your score is \(score)")
            }
        }
        .alert("Game Ended", isPresented: $showingGameOver) {
            Button("Start new game", action: startNewGame)
        } message: {
            Text("Your score was \(score)/\(totalQuestions)")
        }
    }
    
    func flagTapped(_ number: Int) {
        userChoice = number

        let isCorrect = number == answer
        scoreTitle = isCorrect ? "Correct" : "Wrong"
        score += isCorrect ? 1 : 0

        if questionsAsked < totalQuestions {
            showingScore = true
        } else {
            showingGameOver = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        answer = Int.random(in: 0...2)
        questionsAsked += 1
    }
    
    func startNewGame() {
        userChoice = -1
        score = 0
        scoreTitle = ""
        showingScore = false
        questionsAsked = 1
        askQuestion()

        showingGameOver = false
    }
}

#Preview {
    ContentView()
}
