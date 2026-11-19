//
//  Habits.swift
//  HabitTracker
//
//  Created by Kelsey Steven on 11/18/26.
//

import Foundation

struct Habit: Identifiable, Codable {
    var id = UUID()
    let name: String
    let description: String
    var completed: Int
}

@Observable
class Habits {
    var items = [Habit]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Habits") {
            if let decodedItems = try? JSONDecoder().decode([Habit].self,
                                                            from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}
