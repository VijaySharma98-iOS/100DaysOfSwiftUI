//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Vijay Sharma on 17/01/25.
//

import SwiftUI

struct ContentView: View {
    
    let motto1 = Text("Draco dormiens") //Views as properties text is the view
    let motto2 = Text("nunquam titillandus")//Views as properties
    
    var motto3: some View {
        Text("Draco dormiens")
    } // this is the computed properties
    
   // if you want to send multiple views back you have three options.
    //First -
    var spells: some View {
        VStack {
            Text("Lumos")
            Text("Obliviate")
        }
    }
    // second -
    var spells2: some View {
        Group {
            Text("Lumos")
            Text("Obliviate")
        }
    }
    //Third -
    @ViewBuilder var spells3: some View {
        Text("Lumos")
        Text("Obliviate")
    }
    
    var body: some View {
       
        
        
        
        
        
// Environment modifiers https://www.hackingwithswift.com/books/ios-swiftui/environment-modifiers
        /*
        VStack {
            Text("Hello")
                .font(.largeTitle) //This override the Environment modifiers.
                .blur(radius: 5) //But we did not override the blur modifiers
            Text("World")
            Text("Hello")
        }
        //.font(.title) // This is the Environment modifiers
        //.blur(radius: 5) //This is reglur modifiers
         */
        
        
        
        VStack {
            motto1
                .foregroundStyle(.red)
            motto2
                .foregroundStyle(.blue)
        }
    }
}

#Preview {
    ContentView()
}
