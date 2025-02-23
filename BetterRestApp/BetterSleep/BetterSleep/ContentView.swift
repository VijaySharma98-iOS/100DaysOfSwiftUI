//
//  ContentView.swift
//  BetterSleep
//
//  Created by Vijay Sharma on 18/02/25.
//
import CoreML
import SwiftUI


struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultTime
    @State private var coffeeAmount = 0
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert: Bool = false
    
    static var defaultTime: Date  {
        var components = DateComponents()
        components.hour = 5
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationStack {
            Form {
                VStack(alignment: .leading,spacing: 5) {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                VStack(alignment: .leading,spacing: 5) {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                VStack(alignment: .leading,spacing: 5) {
                    Text("Daily coffee intake")
                        .font(.headline)
                    
                    Stepper("\(coffeeAmount.formatted()) cup(s)", value: $coffeeAmount, in: 1...20, step: 1)
                }
            }
            .navigationTitle("Better Sleep")
            .toolbar {
                Button("Calculate",action: calculateBedtime)
                    .foregroundStyle(.black)
                    .bold()
            }
            .alert(alertTitle, isPresented: $showAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    func calculateBedtime() {
        
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour: Double = Double(components.hour ?? 0) * 60 * 60
            let minute: Double = Double(components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: hour + minute, estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is…"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
            //
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        
        showAlert = true
        
    }
}

#Preview {
    ContentView()
}
