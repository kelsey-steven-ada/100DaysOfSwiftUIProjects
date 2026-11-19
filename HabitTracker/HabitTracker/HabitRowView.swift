//
//  HabitView.swift
//  HabitTracker
//
//  Created by Kelsey Steven on 11/18/26.
//

import SwiftUI

struct HabitRowView: View {
    @Binding var habit: Habit
    
    var body: some View {
        HStack {
            Text(habit.name)
                .font(.headline)
            
            Spacer()

            Stepper("^[\(habit.completed) time](inflect:true)",
                    value: $habit.completed,
                    in: 0...1000)
                .fixedSize()
        }
    }
}

#Preview {
    @Previewable @State var habit = Habit(name: "Take a walk",
                      description: "Walk at least 1 km per week",
                      completed: 0)
    HabitRowView(habit: $habit)
}
