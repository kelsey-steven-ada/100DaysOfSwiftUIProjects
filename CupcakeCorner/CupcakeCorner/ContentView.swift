//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Kelsey Steven on 11/18/26.
//

import SwiftUI


struct ContentView: View {
    @State private var order = Order()
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select cake type", selection: $order.type) {
                        ForEach(Order.CakeType.allCases) {
                            Text($0.rawValue)
//                                .tag($0.rawValue.capitalized)
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.quantity)",
                            value: $order.quantity,
                            in: 1...20)
                }
                
                Section {
                    Toggle("Add special requests?", isOn: $order.specialRequestEnabled)
                    
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.addExtraFrosting)
                        Toggle("Add sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink("Delivery Details") {
                        AddressView(order: order)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}
