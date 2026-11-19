//
//  HabitsListView.swift
//  HabitTracker
//
//  Created by Kelsey Steven on 11/18/26.
//

import SwiftUI

struct HabitsListView: View {
    @Bindable var habits: Habits
    @State private var showingAddHabit = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($habits.items) { $habit in
                    NavigationLink {
                        HabitDetailView(habit: habit)
                    } label: {
                        HabitRowView(habit: $habit)
                    }
                }
                .onDelete { offsets in
                    deleteHabits(at: offsets)
                }
            }
            .navigationTitle("HabitTracker")
            .toolbar {
                Button("Add Habit", systemImage: "plus") {
                    showingAddHabit = true
                }
            }
            .sheet(isPresented: $showingAddHabit) {
                CreateHabitView(habits: habits)
            }
        }
    }
    
    func deleteHabits(at offsets: IndexSet) {
        habits.items.remove(atOffsets: offsets)
    }
}

#Preview {
    HabitsListView(habits: Habits())
}
