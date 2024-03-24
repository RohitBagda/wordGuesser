//
//  Constants.swift
//  wordGuesser
//
//  Created by Rohit Bagda on 3/24/24.
//

struct Constants {
    static let qwerty = ["QWERTYUIOP", "ASDFGHJKL", "ZXCVBNM"]
    static let appTitle = "NotWordle"
    static let appDescription = "Can you guess the 5-letter word?"
    static let ruleDescription = "You get 3 strikes!"
    static let hintToggleText = "Hint"
    static let defaultWinGreeting = "Congratulations!"
    static let defaultGameOverGreeting = "Game Over!"
    static let defaultHint = "Unavailable"
    static let newGame = "New Game"
    static let retry = "Retry"
    static let confettiEmoji = "💩"
    static let claimGiftText = "Claim your gift below"
    static let claimGiftEmoji = "🎁"
    static let wordsAndCategories: [String: String] = [
        "Horse": "Animal 🐾",
        "Tiger": "Animal 🐾",
        "Whale": "Animal 🐾",
        "Koala": "Animal 🐾",
        "Eagle": "Animal 🐾",
        "Mouse": "Animal 🐾",
        "Snail": "Animal 🐾",
        "Bison": "Animal 🐾",
        "Zebra": "Animal 🐾",
        "Panda": "Animal 🐾",
        "Shark": "Animal 🐾",
        "Brown": "Color 🖍️",
        "Black": "Color 🖍️",
        "White": "Color 🖍️",
        "Green": "Color 🖍️",
        "Amber": "Color 🖍️",
        "Apple": "Fruit 🍌",
        "Peach": "Fruit 🍌",
        "Mango": "Fruit 🍌",
        "Grape": "Fruit 🍌",
        "Lemon": "Fruit 🍌",
        "Ankle": "Body Part 🦵",
        "Chest": "Body Part 🦵",
        "Wrist": "Body Part 🦵",
        "Heart": "Body Part 🦵",
        "Elbow": "Body Part 🦵",
        "Storm": "Weather 🌦️",
        "Sunny": "Weather 🌦️",
        "Cloud": "Weather 🌦️",
        "Frost": "Weather 🌦️",
        "Rainy": "Weather 🌦️",
        "Maple": "Plant 🪴",
        "Ferns": "Plant 🪴",
        "Daisy": "Plant 🪴",
        "Roses": "Plant 🪴",
        "Tulip": "Plant 🪴",
        "Cedar": "Plant 🪴",
        "Drill": "Tool 🛠️",
        "Screw": "Tool 🛠️",
        "Plier": "Tool 🛠️",
        "Bread": "Food 🥘",
        "Salad": "Food 🥘",
        "Sushi": "Food 🥘",
        "Pizza": "Food 🥘",
        "Bacon": "Food 🥘",
        "Steak": "Food 🥘",
        "Pasta": "Food 🥘",
        "Broth": "Food 🥘",
        "Dress": "Clothing 👘",
        "Glove": "Clothing 👘",
        "Shirt": "Clothing 👘",
        "Socks": "Clothing 👘",
        "Skirt": "Clothing 👘",
        "Jeans": "Clothing 👘",
        "Paris": "City 🏙️ ",
        "Tokyo": "City 🏙️ ",
        "Dubai": "City 🏙️ ",
        "Seoul": "City 🏙️ ",
        "Cairo": "City 🏙️ ",
        "Nurse": "Profession 👮",
        "Pilot": "Profession 👮",
        "Actor": "Profession 👮",
        "Baker": "Profession 👮",
        "Piano": "Instrument 🎸",
        "Flute": "Instrument 🎸",
        "Viola": "Instrument 🎸",
        "Cello": "Instrument 🎸",
        "Organ": "Instrument 🎸",
        "Train": "Transporation 🚌",
        "Plane": "Transporation 🚌",
        "Ferry": "Transporation 🚌",
        "Yacht": "Transporation 🚌",
        "Chess": "Game 🎲",
        "Cards": "Game 🎲",
        "Bingo": "Game 🎲",
        "Darts": "Game 🎲",
        "Sword": "Weapon ⚔️",
        "Rifle": "Weapon ⚔️",
        "Arrow": "Weapon ⚔️",
        "Lance": "Weapon ⚔️",
        "Spear": "Weapon ⚔️",
        "Metal": "Material 💎",
        "Stone": "Material 💎",
        "Glass": "Material 💎",
        "Paper": "Material 💎",
        "Happy": "Emotion 🤔",
        "Angry": "Emotion 🤔",
        "Brave": "Emotion 🤔",
        "Shame": "Emotion 🤔",
        "Panic": "Emotion 🤔",
        "Proud": "Emotion 🤔",
        "Eager": "Emotion 🤔",
        "Doubt": "Emotion 🤔",
        "Eight": "Number 🔢",
        "Three": "Number 🔢",
        "Seven": "Number 🔢",
        "Sugar": "Ingredient 🧂",
        "Flour": "Ingredient 🧂",
        "Spice": "Ingredient 🧂",
        "Yeast": "Ingredient 🧂",
    ].reduce(into: [String: String]()) {
        result, entry in result[entry.key.uppercased()] = entry.value
    }
    
    static let winGreetings = [
        "Wow 🙌",
        "Woohoo 🥳",
        "What a pro 😎",
        "Congratulations 🥳",

    ]
    
    static let winWithNoStrikesAndRetryGreetings = [
        "You are a god 🙏",
        "How did do you do that 👀",
    ]
    
    static let retryWinGreetings = [
        "Finally 🙃",
        "At last 🥸",
        "What took you so long? 😴",
        "Okay but can you get it in one try? 🤓",
        "Next time get it without retrying? 🤠",
    ]
    
    static let lossGreetings = [
        "You can do better 😪",
        "Try harder 🥱",
        "Are you even awake? 😴",
        "You are not good at this 🙄",
        "Need more practice 😒",
        "Don't give up now 🏋️‍♂️",
        "Put on your thinking 🧢",
        "Perhaps use your 🧠 a bit more?",
        "A two year old could've guessed that 👶",
        "Have you heard of an educated guess? 🤷‍♂️",
        "I've got 🧦 smarter than those guesses 🤦‍♂️",
    ]
}
