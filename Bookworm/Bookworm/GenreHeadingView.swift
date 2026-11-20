//
//  GenreHeadingView.swift
//  Bookworm
//
//  Created by Kelsey Steven on 11/19/26.
//

import SwiftUI

struct GenreHeadingView: View {
    var genre: BookGenre
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(genre.rawValue)
                .resizable()
                .scaledToFit()
            
            Text(genre.rawValue.uppercased())
                .font(.caption)
                .fontWeight(.black)
                .padding(8)
                .foregroundStyle(.white)
                .background(.black.opacity(0.75))
                .clipShape(.rect(cornerRadius: 10))
                .offset(x: -5, y: -5)
        }
    }
}

#Preview {
    GenreHeadingView(genre: .fantasy)
}
