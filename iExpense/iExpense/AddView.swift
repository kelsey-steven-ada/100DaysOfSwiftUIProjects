//
//  AddView.swift
//  iExpense
//
//  Created by Kelsey Steven on 11/16/26.
//

import SwiftUI


struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @Environment(\.dismiss) var dismiss
    
    var currencyCode: String {
        Locale.current.currency?.identifier ?? "USD"
    }
    
    var expenses: Expenses
    
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                
                Picker("Type", selection: $type) {
                    ForEach(ExpenseType.allCases) {
                        Text($0.rawValue.capitalized).tag($0.rawValue.capitalized)
                    }
                }
                
                TextField("Amount",
                          value: $amount,
                          format: .currency(code: currencyCode))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add Expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name,
                                           type: ExpenseType(rawValue: type.lowercased())!,
                                           amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
