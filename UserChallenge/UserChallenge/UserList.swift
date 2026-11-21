//
//  UserList.swift
//  UserChallenge
//
//  Created by Kelsey Steven on 11/20/26.
//

import SwiftUI
import SwiftData


struct UserList: View {
    @Query var users: [User]
    
    var body: some View {
        List {
            ForEach(users) { user in
                NavigationLink(value: user) {
                    UserRowView(user: user)
                }
            }
        }
        .navigationDestination(for: User.self) { user in
            UserDetailView(user: user)
        }
    }
    
    init(sortOrder: [SortDescriptor<User>]) {
        _users = Query(sort: sortOrder)
    }
}

#Preview(traits: .modifier(SampleData())) {
    NavigationStack {
        UserList(sortOrder: [SortDescriptor(\User.name)])
    }
}
