//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Kelsey Steven on 11/19/26.
//

import SwiftUI
import SwiftData


@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
