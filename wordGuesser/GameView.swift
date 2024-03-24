//
//  ContentView.swift
//  wordGuesser
//
//  Created by Rohit Bagda on 3/23/24.
//

import SwiftUI
import ConfettiSwiftUI

struct GameView: View {
    private let winGreetingColor = Color.green
    private let lossGreetingColor = Color.red
    private let wordsAndCategories = Constants.wordsAndCategories
    private let lossGreetings = Constants.lossGreetings
    private let winGreetings = Constants.winGreetings
    private let retryWinGreetings = Constants.retryWinGreetings
    private let winWithNoStrikesAndRetryGreetings = Constants.winWithNoStrikesAndRetryGreetings
    
    @State private var confettiStateCounter: Int = 0
    @State private var currentWord = ""
    @State private var hint = ""
    @State private var displayedWord = ""
    @State private var guessedLetters = [Character]()
    @State private var strikes = 0
    @State private var gameOver = false
    @State private var gameWon = false
    @State private var isRetry = false
    @State private var showHint = false
    @State var keyboardState: [Character: Letter] = GameView.defaultKeyboardState()
    
    
    var body: some View {
        VStack {
            Text(Constants.appTitle)
                .font(.largeTitle)
            
            if (gameInProgress()) {
                Text(Constants.appDescription)
                Text(Constants.ruleDescription)
                Text(strikeText())
            }

            Text(displayedWord)
                .font(.title)
                .padding(.top)
            
            if (showHint) { Text(hint) }

            
            // Hint TOGGLE
            if gameInProgress() {
                VStack {
                    Toggle(Constants.hintToggleText, isOn: $showHint)
                        .tint(.blue)
                }
                .frame(width: 90)
                .padding()
                
            }
            
        
            // Build Qwerty Keyboard
            if gameInProgress() {
                ForEach(Constants.qwerty, id: \.self) { qwertyRow in
                    HStack {
                        ForEach(Array(qwertyRow), id: \.self) { letter in
                            createKeyboardButton(letter)
                                .buttonStyle(GrowingButton())
                        }
                    }
                }
            }
            
                        
            // Greetings when game is over
            if gameOver {
                Text(lossGreetings.randomElement() ?? Constants.defaultGameOverGreeting)
                    .foregroundColor(.red)
                    .padding()
            }
            
            // Greetings when game is won
            if gameWon {
                if (isRetry) {
                    Text(Constants.retryWinGreetings.randomElement() ?? Constants.defaultWinGreeting)
                        .foregroundColor(winGreetingColor)
                        .padding()
                } else if (strikes == 0) {
                    Text(Constants.winWithNoStrikesAndRetryGreetings.randomElement() ?? Constants.defaultWinGreeting)
                        .foregroundColor(winGreetingColor)
                    Text(Constants.claimGiftText)
                    Button(action: { confettiStateCounter += 1}) {
                        Text(Constants.claimGiftEmoji).font(.largeTitle)
                    }
                    .padding()
                    .confettiCannon(
                        counter: $confettiStateCounter,
                        confettis: [.text(Constants.confettiEmoji)],
                        confettiSize: 100.0,
                        repetitions: 1
                    )
                } else {
                    Text(Constants.winGreetings.randomElement() ?? Constants.defaultWinGreeting)
                        .foregroundColor(winGreetingColor)
                        .padding()
                }
            }
            
            // New Game and Retry Buttons
            HStack {
                if (gameOver) {
                    Button(Constants.retry) { resetGame(retry: true) }
                        .buttonStyle(CapsuleGrowingButton())
                }
                
                if (!gameInProgress()) {
                    Button(Constants.newGame) { resetGame() }
                        .buttonStyle(CapsuleGrowingButton())
                }
            }
        }
        
        .onAppear {
            currentWord = getRandomWord()
            hint = getHint()
            displayWord()
        }
    }
    
    static func defaultKeyboardState() -> [Character: Letter] {
        Constants.qwerty
            .joined()
            .reduce(into: [Character: Letter]()) {
                (result, letter) in result[letter] = Letter(color: Color.primary, letterState: LetterState.UNGUESSED)
            }
    }
    
    func createKeyboardButton(_ letter: String.Element) -> Button<some View> {
        return Button(action: {
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
    
    func resetGame(retry: Bool = false) {
        currentWord = if (retry) { currentWord } else { getRandomWord() }
        hint = getHint()
        guessedLetters = []
        strikes = 0
        gameOver = false
        gameWon = false
        isRetry = retry
        showHint = if (retry && showHint) { showHint } else { false }
        displayWord()
        keyboardState = GameView.defaultKeyboardState()
    }
    
    func gameInProgress() -> Bool {
        return !gameWon && !gameOver
    }
    
    func getRandomWord() -> String {
        return wordsAndCategories.keys.randomElement()!
    }
    
    func getHint() -> String {
        return wordsAndCategories[currentWord] ?? Constants.defaultHint
    }
    
    func strikeText() -> String {
        var strikeText = ""
        if (strikes > 0) {
            for _ in 0...strikes - 1 {
                strikeText.append("❌")
                
            }
        }
        return strikeText
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
                if (!showHint) { showHint.toggle() }
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

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 3 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct CapsuleGrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
