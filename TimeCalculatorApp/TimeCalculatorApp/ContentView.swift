//
//  ContentView.swift
//  TimeCalculatorApp
//
//  Created by Vijay Sharma on 15/12/24.
//
//Day 19 Challenge day link - https://www.hackingwithswift.com/100/swiftui/19
import SwiftUI

struct ContentView: View {
    // Time units for conversion
    let timeUnits = ["Seconds", "Minutes", "Hours", "Days"]
    
    // State variables
    @State private var inputUnit = "Seconds"
    @State private var outputUnit = "Minutes"
    @State private var inputValue = ""
    @State private var result: Double? = nil
    
    // Conversion logic
    var convertedValue: Double? {
        guard let value = Double(inputValue) else {
            return nil
        }
        
        let inputInSeconds: Double
        switch inputUnit {
        case "Seconds":
            inputInSeconds = value
        case "Minutes":
            inputInSeconds = value * 60
        case "Hours":
            inputInSeconds = value * 3600
        case "Days":
            inputInSeconds = value * 86400
        default:
            inputInSeconds = 0
        }
        
        let outputValue: Double
        switch outputUnit {
        case "Seconds":
            outputValue = inputInSeconds
        case "Minutes":
            outputValue = inputInSeconds / 60
        case "Hours":
            outputValue = inputInSeconds / 3600
        case "Days":
            outputValue = inputInSeconds / 86400
        default:
            outputValue = 0
        }
        
        return outputValue
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input Value")) {
                    TextField("Enter value", text: $inputValue)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Input Unit")) {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(timeUnits, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Output Unit")) {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(timeUnits, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Converted Value")) {
                    if let result = convertedValue {
                        Text("\(result, specifier: "%.2f") \(outputUnit)")
                            .font(.headline)
                    } else {
                        Text("Enter a valid number")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Time Unit Converter")
        }
    }
}

#Preview {
    ContentView()
}
