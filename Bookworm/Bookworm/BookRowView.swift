//
//  BookRowView.swift
//  Bookworm
//
//  Created by Kelsey Steven on 11/19/26.
//

import SwiftUI

struct BookRowView: View {
    var book: Book
    
    var body: some View {
        NavigationLink(value: book) {
            HStack {
                EmojiRatingView(rating: book.rating)
                    .font(.largeTitle)
                
                VStack(alignment: .leading) {
                    Text(book.title)
                        .font(.headline)
                        .foregroundStyle(book.rating == 1 ? .red : .primary)
                    Text(book.author)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

#Preview {
    BookRowView(book: Book.exampleBook)
}
