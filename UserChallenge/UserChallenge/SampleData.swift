//
//  SampleData.swift
//  UserChallenge
//
//  Created by Kelsey Steven on 11/20/26.
//

import Foundation
import SwiftData
import SwiftUI


struct SampleData: PreviewModifier {
    static func makeSharedContext() throws -> ModelContainer {
        let container = try ModelContainer(for: User.self)
        try? container.mainContext.delete(model: User.self)

        let friendOne = Friend(id: "One", name: "Amy Ashland")
        let friendTwo = Friend(id: "Two", name: "Benny Booth")
        let newUser = User(id: "userID12345",
                           isActive: true,
                           registered: .now,
                           name: "New User",
                           age: 30,
                           company: "A company",
                           email: "new.user@newuser.com",
                           address: "street address, city, state zip",
                           about: "This could be a long description, but I really don't want to write or find one so this is about how much we're gonna fill",
                           tags: ["hasfriends", "notalone", "likesmedia"],
                           friends: [friendOne, friendTwo])
        
        container.mainContext.insert(newUser)
        return container
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}
