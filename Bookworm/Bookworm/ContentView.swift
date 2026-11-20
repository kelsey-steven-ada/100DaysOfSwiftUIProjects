//
//  ContentView.swift
//  Bookworm
//
//  Created by Kelsey Steven on 11/19/26.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    static let bookSorting = [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]
    
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: ContentView.bookSorting) var books: [Book]
    @State private var showingAddBook = false
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    BookRowView(book: book)
                }
                .onDelete(perform: deleteBooks)
            }
                .navigationDestination(for: Book.self) { book in
                    BookDetailView(book: book)
                }
                .navigationTitle("Bookworm")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add Book", systemImage: "plus") {
                            showingAddBook = true
                        }
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                }
                .sheet(isPresented: $showingAddBook) {
                    AddBookView()
                }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
