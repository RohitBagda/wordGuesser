//
//  ContentView.swift
//  wordGuesser
//
//  Created by Rohit Bagda on 3/23/24.
//

import SwiftUI
import ConfettiSwiftUI

struct ContentView: View {
    private let qwerty = ["QWERTYUIOP", "ASDFGHJKL", "ZXCVBNM"]
    private let words = [
        "apple", "water", "house", "river", "beach", "sound", "light", "green", "table", "chair",
        "night", "music", "laugh", "heart", "peace", "happy", "brown", "young", "sweet", "bread",
        "white", "black", "stone", "small", "large", "plant", "bloom", "grace", "train", "track",
        "frame", "clock", "cloud", "storm", "frost", "royal", "sugar", "honey", "spicy", "drink",
        "olive", "dance", "tired", "movie", "right", "wrong", "solar", "space", "ocean", "eager",
        "paint", "magic", "field", "berry", "pasta", "pizza", "party", "flame", "smart", "touch",
        "dream", "angle", "eager", "novel", "hotel", "ghost", "daily", "tower", "world", "third",
        "robot", "quest", "mango", "start", "steel", "style", "pearl", "tough", "judge", "phase",
        "radar", "scent", "lucky", "shelf", "skill", "brave", "sweet", "urban", "viral", "yeast",
        "youth", "zesty", "vigor", "wheat", "wasps", "valid", "usher", "upper", "unite", "truth"
    ].map { $0.uppercased() }
    
    private let defaultWinGreeting = "Congratulations!"
    private let winGreetingColor = Color.green
    private let lossGreetingColor = Color.red
    private let winGreetings = [
        "Congratulations 🥳",
        "Woohoo 🥳",
        "Wow 🙌",
        "What a pro 😎"
    ]
    
    private let winWithoutStrikesAndRetryGreetings = [
        "You are a god 🙏",
        "How did do you do that 👀",
    ]
    
    private let retryWinGreetings = [
        "Finally 🙃",
        "At last 🥸",
        "Okay but can you get it in one? 🤓",
        "What took you so long? 😴",
        "Next time get it without retrying? 🤠",
    ]
    
    private let lossGreetings = [
        "You can do better 😪",
        "Try harder 🥱",
        "Are you even awake? 😴",
        "You are not good at this 🙄",
        "Need more practice 😒",
        "Don't give up now 🏋️‍♂️",
        "Put on your thinking 🧢",
        "Perhaps use your 🧠 a bit more?",
        "Have you heard of an educated guess? 🤷‍♂️",
        "I've got 🧦 smarter than those guesses 🤦‍♂️",
        "Do I have to build a hint feature for you? 🫣"
    ]
    
    @State private var counter: Int = 0
    @State private var currentWord = ""
    @State private var displayedWord = ""
    @State private var guessedLetters = [Character]()
    @State private var strikes = 0
    @State private var gameOver = false
    @State private var gameWon = false
    @State private var isRetry = false
    @State var keyboardState: [Character: Letter] = "QWERTYUIOPASDFGHJKLZXCVBNM"
        .reduce(into: [Character: Letter]()) {
            (result, letter) in result[letter] = Letter(color: Color.primary, letterState: LetterState.UNGUESSED)
        }
    
    var body: some View {
        VStack {
            Text("NotWordle")
                .font(.largeTitle)
            Text("Can you guess the 5-letter word?")
            
            Text(displayedWord)
                .font(.title)
                .padding()
            
            Text("Strikes: \(strikes)")
                .padding()
            
            
            if gameOver {
                Text(lossGreetings.randomElement() ?? "Game Over!")
                    .foregroundColor(.red)
            }
            
            if gameWon {
                if (isRetry) {
                    Text(retryWinGreetings.randomElement() ?? defaultWinGreeting)
                        .foregroundColor(winGreetingColor)
                } else if (strikes == 0) {
                    Text(winWithoutStrikesAndRetryGreetings.randomElement() ?? defaultWinGreeting)
                        .foregroundColor(winGreetingColor)
                    Text("Claim your gift below")
                    Button(action: { counter += 1}) {
                        Text("🎁")
                            .font(.largeTitle)
                    }.padding()
                    .confettiCannon(counter: $counter, confettis: [.text("💩")], confettiSize: 100.0, repetitions: 1)
                } else {
                    Text(winGreetings.randomElement() ?? defaultWinGreeting)
                        .foregroundColor(winGreetingColor)
                }
            }
            
            VStack {
                if !gameOver && !gameWon {
                    ForEach(qwerty, id: \.self) { row in
                        HStack {
                            ForEach(Array(row), id: \.self) { letter in
                                Button(action: {
                                    let guessResult = checkGuess(letter)
                                    switch(guessResult) {
                                        case .CORRECT:
                                            keyboardState[letter]?.letterState = LetterState.GUESSED_CORRECT
                                            keyboardState[letter]?.color = Color.green
                                        case .INCORRECT:
                                            keyboardState[letter]?.letterState = LetterState.GUESSED_INCORRECT
                                            keyboardState[letter]?.color = Color.red
                                        case .none:
                                            {}() // NO - OP
                                    }
                                }) {
                                       Text(String(letter))
                                           .font(.title)
                                           .foregroundColor(keyboardState[letter]?.color ?? Color.primary)
                                           .padding(5)
                                }
                            }
                        }
                    }
                }
            }
            
            HStack {
                if (gameOver) {
                    Button("Retry") {
                        currentWord = currentWord
                        guessedLetters = []
                        strikes = 0
                        gameOver = false
                        gameWon = false
                        isRetry = true
                        displayWord()
                        keyboardState = defaultKeyboardState()
                    }
                    .padding()
                }
                
                if (gameOver || gameWon) {
                    Button("New Game") {
                        currentWord = getRandomWord()
                        guessedLetters = []
                        strikes = 0
                        gameOver = false
                        gameWon = false
                        isRetry = false
                        displayWord()
                        keyboardState = defaultKeyboardState()
                    }
                    .padding()
                }
            }
        }
        
        .onAppear {
            currentWord = getRandomWord()
            displayWord()
        }
    }
    
    func defaultKeyboardState() -> [Character: Letter] {
        qwerty
            .joined()
            .reduce(into: [Character: Letter]()) {
                (result, letter) in result[letter] = Letter(color: Color.primary, letterState: LetterState.UNGUESSED)
            }
    }
    
    func getRandomWord() -> String {
        return words.randomElement()!
    }
    
    func displayWord() {
        displayedWord = String(currentWord.map { guessedLetters.contains($0) ? $0 : "_" })
    }
    
    func checkGuess(_ letter: Character) -> GuessResult? {
        var guessResult: GuessResult?
        if (!gameWon && !gameOver) {
            if currentWord.contains(letter) {
                guessResult = GuessResult.CORRECT
            } else {
                if (!guessedLetters.contains(letter)) {
                    guessResult = GuessResult.INCORRECT
                    strikes += 1
                } else {
                    guessResult = GuessResult.INCORRECT
                }
                if strikes >= 3 {
                    gameOver = true
                }
            }
            guessedLetters.append(letter)
            displayWord()
            if !displayedWord.contains("_") {
                gameWon = true
            }
        }
        return guessResult
    }
}

enum GuessResult {
    case CORRECT
    case INCORRECT
}

struct Letter {
    var color: Color
    var letterState: LetterState
}

enum LetterState {
    case UNGUESSED
    case GUESSED_CORRECT
    case GUESSED_INCORRECT
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
