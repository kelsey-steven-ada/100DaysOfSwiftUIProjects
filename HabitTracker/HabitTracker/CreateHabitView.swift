//
//  CreateHabitView.swift
//  HabitTracker
//
//  Created by Kelsey Steven on 11/18/26.
//

import SwiftUI


struct CreateHabitView: View {
    @State private var name = ""
    @State private var description = ""
    @State private var timesCompleted = 0
    @State private var showingSaveError = false
    
    @Environment(\.dismiss) var dismiss
    
    var habits: Habits
    
    
    var body: some View {
        VStack {
            if showingSaveError {
                Text("A name and description is required to save")
                    .font(.headline)
                    .foregroundStyle(.red)
                    .padding(.top, 15)
            }
            
            Form {
                TextField("Name", text: $name)
                
                TextField("Description", text: $description)
                
                Stepper("Times completed: \(timesCompleted)",
                        value: $timesCompleted,
                        in: 0...50)
            }
            
            Spacer()
            
            Button("Save") {
                guard !name.isEmpty && !description.isEmpty else {
                    showingSaveError = true
                    return
                }
                
                let newHabit = Habit(name: name,
                                     description: description,
                                     completed: timesCompleted)
                habits.items.append(newHabit)
                dismiss()
            }
        }
        .navigationTitle("Add a habit")
    }
}

#Preview {
    CreateHabitView(habits: Habits())
}
