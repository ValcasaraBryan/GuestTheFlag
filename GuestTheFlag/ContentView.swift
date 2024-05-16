//
//  ContentView.swift
//  GuestTheFlag
//
//  Created by valcasara-bryan on 16/05/2024.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var tourCount = 8
    var body: some View {
        ZStack {
            //LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
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
                        if (tourCount > 0) {
                            VStack {
                                Text("Tap the flag of")
                                    .foregroundStyle(.secondary)
                                    .font(.subheadline.weight(.heavy))
                                Text(countries[correctAnswer])
                                
                                    .font(.largeTitle.weight(.semibold))
                            }
                            ForEach(0..<3) { number in
                                Button {
                                    flagTapped(number)
                                } label: {
                                    Image(countries[number])
                                        .clipShape(.capsule)
                                        .shadow(radius: 5)
                                }
                            }
                        } else {
                            Button(action: {
                                tourCount = 8
                                userScore = 0
                            }) {
                                Text("Reset the game")
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                Text("Score: \(userScore) / 8")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
                
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(userScore) / 8")
        }
    }
    
    func flagTapped(_ number: Int) {
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
            askQuestion()
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            showingScore = true
        }
        tourCount -= 1
        
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
