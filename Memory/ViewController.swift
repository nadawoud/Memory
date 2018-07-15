//
//  ViewController.swift
//  Memory
//
//  Created by Nada Dawoud on 5/30/18.
//  Copyright © 2018 Mobile Apps Kitchen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Memory(numberOfPairsOfCards: (cardButtons.count + 1) / 2 )
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var flipCountLabel: UILabel!
   
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateView()
        }
    }
    
    func updateView() {
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card ), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8588235294, blue: 0.8862745098, alpha: 1)
            }
            else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 0) : #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            }
        }
    }
    
    var themeEmoji = ["Faces": ["🤠", "🤣", "😇", "😍", "😱", "🤪", "🤩", "🤓", "🧐", "😴"],
                  "Animal Faces": ["🐶", "🦁", "🐵", "🐰", "🐼", "🐯","🐴","🐺", "🐮", "🐨"],
                  "Sea Animals": ["🐙", "🦐", "🦀", "🐠", "🐳", "🐬", "🐋", "🦈", "🐡", "🦑"],
                  "Sports": ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓", "🥊"],
                  "Random" : ["🔮", "💎", "🎉", "🎊", "👾", "🤖", "✨", "🎲", "🎮", "🎯"],
                  "Flags": ["🇦🇹", "🇦🇺", "🇩🇿", "🇨🇦", "🇪🇬", "🇬🇹", "🇰🇷", "🇺🇸", "🇬🇧", "🇸🇩"],
                  "Animals": ["🦓", "🐘", "🐪", "🦒", "🐄", "🐈", "🐿", "🐇", "🦌", "🐏"]]
    
    var emojiChoices = ["🤠", "🤣", "😇", "😍", "😱", "🤪", "🤩", "🤓", "🧐", "😴"]
    
    var emoji = [Card: String]()
    
    func randomizeTheme() {
        emoji = [Card: String]()
        
        let themes = Array(themeEmoji.keys)
        let randomIndex = Int(arc4random_uniform(UInt32(themes.count)))
        if let emojies = themeEmoji[themes[randomIndex]] {
            emojiChoices = emojies
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card] ?? "♦️"
    }
   
    @IBAction func startNewGame(_ sender: UIButton) {
        game.reset()
        randomizeTheme()
        updateView()
    }
}

