//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Vijay Sharma on 17/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countriesArray = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var gameScore = 0
    @State private var questionsAsked = 0
    @State private var showingGameOver = false
    
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countriesArray[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            //flag tapped
                            flagTapped(number)
                        } label: {
                            FlagImageView(countries: countriesArray, number: number)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(gameScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Text("Question \(questionsAsked) of 8") // Show the current question number
                    .foregroundStyle(.white)
                    .font(.subheadline.bold())
                Spacer()
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue",action: askQuestion)
        } message: {
            Text("Your score is \(gameScore)")
            //\(scoreTitle)")
        }
        .alert("Game Over", isPresented: $showingGameOver) {
            Button("Restart", action: restartGame)
        } message: {
            Text("You answered all 8 questions! Your final score is \(gameScore).")
        }
        
        
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "You got it!"
            gameScore += 1
            
        } else {
            if gameScore > 0 {
                gameScore -= 1
            }
            scoreTitle = "Wrong! This flag is \(countriesArray[number])"
        }
        showingScore = true
        questionsAsked += 1
    }
    func askQuestion() {
        
        if questionsAsked >= 8 {
            showingGameOver = true
        } else {
            countriesArray.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    }
    func restartGame() {
        // Reset the game
        gameScore = 0
        questionsAsked = 0
        countriesArray.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}

struct FlagImageView: View {
    var countries: [String]
    var number: Int
    
    var body: some View {
        Image(countries[number])
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}
