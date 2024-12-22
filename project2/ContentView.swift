//
//  ContentView.swift
//  project2
//
//  Created by Hadi on 02/05/1446 AH.
//

import SwiftUI

struct FlagImage: View{
    var flagFileName: String
    
    var body: some View{
        Image(flagFileName)
             .clipShape(.capsule)
            .shadow(radius: 20)
    }
}





struct ContentView: View {
    @State private var countries = ["Estonia" , "France", "Germany" , "Ireland" , "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US" ].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var showingEndGameScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var numberOfAttempt = 0
    
    
    
    var body: some View {
        ZStack{
            RadialGradient(stops:[
                .init(color: Color(red:0.1 , green: 0.2 , blue: 0.45), location: 0.3),
                .init(color: Color(red:0.7 , green:0.15 , blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack{
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                
                VStack(spacing: 30){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3){ number in
                        Button{
                            flagTapped(number)
                        }label: {
                            FlagImage(flagFileName: countries[number])
                               
                            
                        }
                    }
                    
                }
                
                .padding(.vertical,20)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                Text("Attempt: \(numberOfAttempt)/8")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding()
            
            .alert(scoreTitle, isPresented: $showingScore){
                Button("Continue", action: askQuestion)
            }message: {
                Text("Your score is \(score)")
            }
            
            .alert("Game Over", isPresented: $showingEndGameScore){
                Button("Restart", action: restart)
            }message: {
                Text("You got \(score) out of 8  Good Job :)")
            }
            
            
        }
      
    }
    
    
    func flagTapped (_ number:Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            score += 1
           
        }else{
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
        showingScore = true
        numberOfAttempt += 1
        
        if numberOfAttempt == 8{
            showingEndGameScore = true
        }
    }
    
    
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restart()
    {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        score = 0
        numberOfAttempt = 0
    }
    
}

#Preview {
    ContentView()
}
