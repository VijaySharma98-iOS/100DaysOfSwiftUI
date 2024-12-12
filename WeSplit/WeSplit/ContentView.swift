//
//  ContentView.swift
//  WeSplit
//
//  Created by Vijay Sharma on 09/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    var tipPercentages = [10, 15, 20, 25 , 0]
    
    var totalPerPerson: Double {
        
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount /; 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var originalAmount: Double {
        checkAmount + Double(tipPercentage)
    }
    
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Check Amount") {
                    TextField("Check Amount",
                              value: $checkAmount,
                              format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.numberPad)
                    .focused($amountIsFocused)
                    Picker("Number of people",selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("How much do you want to tip") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("Amount per person") {
                    Text(totalPerPerson,
                         format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                Section("Original Amount") {
                    Text(originalAmount,
                         format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
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
