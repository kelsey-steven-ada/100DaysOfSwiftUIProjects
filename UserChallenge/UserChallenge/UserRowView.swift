//
//  UserRowView.swift
//  UserChallenge
//
//  Created by Kelsey Steven on 11/20/26.
//

import SwiftUI
import SwiftData


struct UserRowView: View {
    var user: User
    
    var body: some View {
        HStack {
            VStack {
                Text(user.name)
                    .font(.headline)
                Text(user.company)
                    .font(.subheadline)
            }
        }
    }
}

#Preview(traits: .modifier(SampleData())) {
    @Previewable @Query var users: [User]
    UserRowView(user: users.first!)
}

