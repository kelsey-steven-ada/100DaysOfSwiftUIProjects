//
//  PreviewHelpers.swift
//  Bookworm
//
//  Created by Kelsey Steven on 11/19/26.
//

// Content of this file are only available for development/debugging
// This file has been removed from compiling for the release target

extension Book {
    static var exampleBook: Book {
        return Book(title: "Title 1",
                    author: "Author 1",
                    genre: .fantasy,
                    review: "Short review",
                    rating: 4)
    }
}
