//
//  ContentView.swift
//  HabitTracker
//
//  Created by Kelsey Steven on 11/18/26.
//

import SwiftUI

struct ContentView: View {
    @State private var habits = Habits()
    
    var body: some View {
        HabitsListView(habits: habits)
    }
}

#Preview {
    ContentView()
}
