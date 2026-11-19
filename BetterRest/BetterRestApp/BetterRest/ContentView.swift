//
//  ContentView.swift
//  BetterRest
//
//  Created by Kelsey Steven on 11/14/26.
//

import SwiftUI
import CoreML

struct ContentView: View {
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    @State private var wakeUp = ContentView.defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var sleepTime = Date.now
    @State private var hasCalculation = false
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var sleepTimeText: String {
        let formattedDate = sleepTime.formatted(date: .omitted, time: .shortened)
        return "Your ideal bedtime is \(formattedDate)"
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    VStack {
                        Text("When do you want to wake up?")
                            .font(.headline)
                        DatePicker("Please enter a time",
                                   selection: $wakeUp,
                                   displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    
                    VStack {
                        Text("Desired amount of sleep")
                            .font(.headline)
                        Stepper("\(sleepAmount.formatted()) hours",
                                value: $sleepAmount,
                                in: 4...12, step: 0.25)
                    }
                    
                    VStack {
                        Text("Daily coffee intake")
                            .font(.headline)
                        Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)
                    }
                }
                
                if hasCalculation {
                    Text(sleepTimeText)
                }
            }
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateBedtime)
            }
                .alert(alertTitle, isPresented: $showingAlert) {
                    Button("OK") { }
                } message: {
                    Text(alertMessage)
                }
        }
    }
    
    func calculateBedtime() {
        let config = MLModelConfiguration()
        
        let model: SleepCalculator
        do {
            model = try SleepCalculator(configuration: config)
        } catch {
            let message = "Sorry, there was an issue loading the SleepCalculator model."
            showModellingAlert(errorMessage: message)
            return
        }
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        let totalSeconds = hour + minute
        
        let prediction: SleepCalculatorOutput
        do {
            prediction = try model.prediction(
                wake: Double(totalSeconds),
                estimatedSleep: sleepAmount,
                coffee: Double(coffeeAmount))
        } catch {
            let message = "Sorry, there was an issue creating the sleep prediction."
            showModellingAlert(errorMessage: message)
            return
        }
        
        sleepTime = wakeUp - prediction.actualSleep
        hasCalculation = true
    }
    
    
    func showModellingAlert(errorMessage: String) {
        alertTitle = "Error"
        alertMessage = errorMessage
        showingAlert = true
    }
}

#Preview {
    ContentView()
}
