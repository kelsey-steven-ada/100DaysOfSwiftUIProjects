//
//  AddBookView.swift
//  Bookworm
//
//  Created by Kelsey Steven on 11/19/26.
//

import SwiftUI
import SwiftData


struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre: BookGenre = .fantasy
    @State private var review = ""
    @State private var isShowingError = false
    
    var isBookDataValid: Bool {
        let titleOkay = !(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        let authorOkay = !(author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        
        return titleOkay && authorOkay
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Book Details") {
                    TextField("Book title", text: $title)
                    TextField("Author's name", text: $author)
                        .autocorrectionDisabled()
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(BookGenre.allCases) {
                            Text($0.rawValue)
                                .tag($0)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        saveBook()
                    }
                }
            }
            .navigationTitle("Add Book")
            .alert("Could not save", isPresented: $isShowingError) {
                Button("Okay") { }
            } message: {
                Text("Both the title and author fields must be filled.")
            }
        }
    }
    
    func saveBook() {
        if isBookDataValid {
            let newBook = Book(title: title,
                               author: author,
                               genre: genre,
                               review: review,
                               rating: rating)
            modelContext.insert(newBook)
            dismiss()
        } else {
            isShowingError = true
        }
    }
}

#Preview {
    AddBookView()
}
