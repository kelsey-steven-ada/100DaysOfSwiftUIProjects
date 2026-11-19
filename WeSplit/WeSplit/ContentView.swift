//
//  ContentView.swift
//  WeSplit
//
//  Created by Kelsey Steven on 11/12/26.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    
    let tipPercentages = [10, 15, 20, 25, 0]
    let locale = Locale.current.currency?.identifier ?? "USD"
    
    var splitAmount: Double {
        let tip = checkAmount * (Double(tipPercentage) / 100)
        let grandTotal = checkAmount + tip
        return grandTotal / (Double(numberOfPeople) + 2)
    }
    

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Check Total",
                              value: $checkAmount,
                              format: .currency(code: locale))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people",
                           selection: $numberOfPeople) {
                            ForEach(2..<100) {
                                Text("\($0) people")
                            }
                        }
                        .pickerStyle(.navigationLink)
                }
                
                Section("How much would you like to tip?") {
                    Picker("Tip Percentage",
                           selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                           .pickerStyle(.segmented)
                }
                
                Section("Total per person") {
                    Text(splitAmount,
                         format: .currency(code: locale))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
