//
//  UserDetailView.swift
//  UserChallenge
//
//  Created by Kelsey Steven on 11/20/26.
//

import SwiftUI
import SwiftData


struct UserDetailView: View {
    var user: User
    
    var body: some View {
        ScrollView {
            Section {
                HStack {
                    VStack {
                        Text(user.name)
                            .font(.headline)
                        Text("Age: \(user.age)")
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    
                    Text(user.company)
                }
                .padding()
                
                Text(user.about)
            } header: {
                Text("Personal Info")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.blue)
            }
                        
            Section {
                VStack {
                    Text("Tags")
                        .font(.headline)
                    ForEach(user.tags, id: \.self) { tag in
                        Text(tag)
                    }
                }
                
                VStack {
                    Text("Friends")
                        .font(.headline)
                    ForEach(user.friends) { friend in
                        Text(friend.name)
                    }
                }
            } header: {
                Text("Friends & Interests")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.blue)
            }
            .padding(.top, 15)
        }
        .navigationTitle("User Details")
    }
}

#Preview(traits: .modifier(SampleData())) {
    @Previewable @Query var users: [User]
    NavigationStack {
        UserDetailView(user: users.first!)
    }
}
