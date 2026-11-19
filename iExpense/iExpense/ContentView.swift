//
//  ContentView.swift
//  iExpense
//
//  Created by Kelsey Steven on 11/16/26.
//

import SwiftUI

enum ExpenseType: String, CaseIterable, Codable, Identifiable {
    case business
    case personal
    var id: Self { self }
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: ExpenseType
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self,
                                                            from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}

struct ExpenseView: View {
    static var currencyCode: String {
        Locale.current.currency?.identifier ?? "USD"
    }
    var item: ExpenseItem
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type.rawValue)
            }
            
            Spacer()
            Text(item.amount,
                 format: .currency(code: ExpenseView.currencyCode))
        }
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var personalExpenses: [ExpenseItem] {
        return expenses.items.filter {
            $0.type == .personal
        }
    }
        
    var body: some View {
        NavigationStack {
            List {
                ForEach(ExpenseType.allCases) { type in
                    let filteredItems = expenses.items.filter { $0.type == type }
                    if !filteredItems.isEmpty {
                        Section(header: Text(type.rawValue.capitalized)) {
                            ForEach(filteredItems) { item in
                                ExpenseView(item: item)
                            }
                            .onDelete { offsets in
                                deleteItems(at: offsets, in: filteredItems)
                            }
                        }
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    
    func deleteItems(at offsets: IndexSet, in filteredList: [ExpenseItem]) {
        let idsToDelete = offsets.map { filteredList[$0].id }
        expenses.items.removeAll { idsToDelete.contains($0.id) }
    }
}


#Preview {
    ContentView()
}
