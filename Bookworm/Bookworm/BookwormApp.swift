//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Kelsey Steven on 11/19/26.
//

import SwiftUI
import SwiftData


@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
