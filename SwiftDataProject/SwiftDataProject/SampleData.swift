//
//  SampleData.swift
//  SwiftDataProject
//
//  Created by Kelsey Steven on 11/19/26.
//

import Foundation
import SwiftData
import SwiftUI


struct SampleData: PreviewModifier {
    static func makeSharedContext() throws -> ModelContainer {
        let container = try ModelContainer(for: User.self)
        let newUser = User(name: "Julia",
                           city: "Jacob",
                           joinDate: Date.now)
        container.mainContext.insert(newUser)
        return container
    }


    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
 }
