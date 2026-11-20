//
//  Book.swift
//  Bookworm
//
//  Created by Kelsey Steven on 11/19/26.
//

import SwiftData


@Model
class Book {
    var title: String
    var author: String
    var genre: BookGenre
    var review: String
    var rating: Int
    
    init(title: String, author: String, genre: BookGenre, review: String, rating: Int) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
    }
}

enum BookGenre: String, Codable, Identifiable, CaseIterable {
    var id: Self { self }

    case fantasy = "Fantasy"
    case horror = "Horror"
    case kids = "Kids"
    case mystery = "Mystery"
    case poetry = "Poetry"
    case romance = "Romance"
    case thriller = "Thriller"
}

