//
//  UserChallengeApp.swift
//  UserChallenge
//
//  Created by Kelsey Steven on 11/20/26.
//

import SwiftUI
import SwiftData


@main
struct UserChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
