//
//  ContentView.swift
//  RockPaperScissorsApp
//
//  Created by Vijay Sharma on 07/02/25.
//

import SwiftUI

//struct ContentView: View {
//    @State private var selectedOption = ""
//    @State private var randomOption = ["Rock", "Paper", "Scissors"]
//    
//    //    var
//    
//    var body: some View {
//        NavigationStack {
//            Form {
//                Text("You Selected: \(selectedOption)")
//                    .font(.headline)
//                    .foregroundColor(.blue)
//                
//                if !selectedOption.isEmpty {
//                    Text("Computer Selected: \(randomOption.randomElement() ?? "")")
//                        .font(.headline)
//                        .foregroundColor(.blue)
//                }
//                
//                Section {
//                    Picker("Select Option", selection: $selectedOption) {
//                        Text("Rock").tag("Rock")
//                        Text("Paper").tag("Paper")
//                        Text("Scissors").tag("Scissors")
//                    }
//                    .bold()
//                }
//                Section {
//                    Button{
//                        
//                    } label: {
//                        Text("Tap Me")
//                            .padding()
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                        
//                        
//                    }
//                }
//            }
//            .navigationTitle("Rock Paper Scissors")
//        }
//    }
//}
struct ContentView: View {
    let moves = ["Rock", "Paper", "Scissors"]
    
    @State private var appChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var questionCount = 0
    @State private var showAlert = false
    
    var correctMove: String {
        switch (moves[appChoice], shouldWin) {
        case ("Rock", true): return "Paper"
        case ("Rock", false): return "Scissors"
        case ("Paper", true): return "Scissors"
        case ("Paper", false): return "Rock"
        case ("Scissors", true): return "Rock"
        case ("Scissors", false): return "Paper"
        default: return "Rock"
        }
    }
    
    func moveTapped(_ move: String) {
        if move == correctMove {
            score += 1
        } else {
            score -= 1
        }
        
        questionCount += 1
        if questionCount == 10 {
            showAlert = true
        } else {
            nextRound()
        }
    }
    
    func nextRound() {
        appChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
    
    func restartGame() {
        score = 0
        questionCount = 0
        nextRound()
    }
    
    var body: some View {
        VStack {
            Text("Rock, Paper, Scissors")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("App chose: \(moves[appChoice])")
                .font(.title2)
                .padding()
            
            Text("Your goal: \(shouldWin ? "Win" : "Lose")")
                .font(.title2)
                .padding()
            
            HStack {
                ForEach(moves, id: \..self) { move in
                    Button(action: {
                        moveTapped(move)
                    }) {
                        Text(move)
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            .padding()
            
            Text("Score: \(score)")
                .font(.title)
                .padding()
        }
        .alert("Game Over", isPresented: $showAlert) {
            Button("Restart", action: restartGame)
        } message: {
            Text("Your final score is \(score)")
        }
    }
}

#Preview {
    ContentView()
}
