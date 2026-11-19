//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Kelsey Steven on 11/18/26.
//

import SwiftUI

struct CheckoutView: View {
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    let cupcakeURLString = "https://hws.dev/img/cupcakes@3x.jpg"
    var order: Order
    
    var currencyCode: String {
        Locale.current.currency?.identifier ?? "USD"
    }
    
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: cupcakeURLString),
                           scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is: \(order.cost, format: .currency(code: currencyCode))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }
        .navigationTitle("Check Out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank You!", isPresented: $showingConfirmation) {
            Button("Okay") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to order")
            return
        }
        
        let url = URL(string: "https://httpbun.com/payload")!
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(decodedOrder.type.rawValue.lowercased()) cupcakes is on the way!"
            showingConfirmation = true
        } catch {
            print("Checkout failed: \(error.localizedDescription)")
        }
    }
}

#Preview {
    NavigationStack {
        CheckoutView(order: Order())
    }
}
