//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Kelsey Steven on 11/20/26.
//

import SwiftData
import SwiftUI


struct UsersView: View {
    @Query var users: [User]

    var body: some View {
        List(users) { user in
            NavigationLink(value: user) {
                Text(user.name)
            }
        }
    }
    
    init(minJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User> { user in
            user.joinDate >= minJoinDate
        }, sort: sortOrder)
    }
}

#Preview {
    UsersView(minJoinDate: .now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
