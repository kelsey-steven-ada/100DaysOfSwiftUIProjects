//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Kelsey Steven on 11/18/26.
//

import SwiftUI

struct HabitDetailView: View {
    var habit: Habit
    
    var body: some View {
        VStack {
            Text("Completed ^[\(habit.completed) time](inflect: true)")
                .font(.headline)
            .padding(.top, 15)
            
            Spacer()
            
            Text("Description:")
                .font(.headline)
            Text(habit.description)
            
            Spacer()
            Spacer()
        }
        .navigationTitle(habit.name)
    }
}

#Preview {
    let habit = Habit(name: "Take a walk",
                      description: "Walk at least 1 km per week",
                      completed: 0)
    NavigationStack {
        HabitDetailView(habit: habit)
    }
}
