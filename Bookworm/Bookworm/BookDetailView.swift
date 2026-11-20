//
//  BookDetailView.swift
//  Bookworm
//
//  Created by Kelsey Steven on 11/19/26.
//

import SwiftUI
import SwiftData


struct BookDetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var book: Book
    
    var body: some View {
        ScrollView {
            GenreHeadingView(genre: book.genre)
            
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)
            
            Text(book.review)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
                .disabled(true) // prevents buttons flashing if pressed in read only view
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .toolbar {
            Button("Delete this book", systemImage: "trash") {
                showingDeleteAlert = true
            }
        }
        .alert("Delete Book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBookAndCloseView)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you?")
        }
    }
    
    func deleteBookAndCloseView() {
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    NavigationStack {
        BookDetailView(book: Book.exampleBook)
    }
}

// The code below requires importing SwiftData
//
//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: Book.self, configurations: config)
//        let example = Book(title: "Test Book", author: "Test Author", genre: "Fantasy", review: "This was a great book; I really enjoyed it.", rating: 4)
//
//        return DetailView(book: example)
//            .modelContainer(container)
//    } catch {
//        return Text("Failed to create preview: \(error.localizedDescription)")
//    }
//}
