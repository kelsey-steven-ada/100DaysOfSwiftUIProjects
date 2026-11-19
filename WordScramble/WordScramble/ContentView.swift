//
//  ContentView.swift
//  WordScramble
//
//  Created by Kelsey Steven on 11/14/26.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word",
                              text: $newWord)
                        .textInputAutocapitalization(.never)
                        .onSubmit(addNewWord)
                    
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) { } message: {
                Text(errorMessage)
            }
        }
    }
    
    func startGame() {
        guard let startWordsURL = Bundle.main.url(forResource: "start",
                                                  withExtension: "txt"),
                let startWords = try? String(contentsOf: startWordsURL,
                                             encoding: .utf8)
        else {
            fatalError("Could not load start.txt from bundle.")
        }
        
        let allWords = startWords.components(separatedBy: .newlines)
        rootWord = allWords.randomElement() ?? "Silkworm"
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            showWordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            showWordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }

        guard isReal(word: answer) else {
            showWordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        let rootCounts = getLetterCounts(for: rootWord)
        print(rootCounts)
        print(rootWord)
        let wordCounts = getLetterCounts(for: word)
        print(wordCounts)
        
        for (char, charCount) in wordCounts {
            let rootCount = rootCounts[char] ?? 0
            if charCount > rootCount {
                return false
            }
        }
        
        return true
    }
    
    func getLetterCounts(for word: String) -> [Character:Int]  {
        var wordCounts: [Character:Int] = [:]
        for letter in word {
            let existingCount = wordCounts[letter] ?? 0
            wordCounts[letter] = existingCount + 1
        }
        return wordCounts
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0,
                            length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word,
                                                            range: range,
                                                            startingAt: 0,
                                                            wrap: false,
                                                            language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func showWordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

#Preview {
    ContentView()
}
