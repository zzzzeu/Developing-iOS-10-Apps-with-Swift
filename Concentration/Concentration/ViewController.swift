//
//  ViewController.swift
//  Concentration
//
//  Created by 总受 on 2018/10/15.
//  Copyright © 2018 com.zeu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (Buttons.count + 1) / 2
    }
    
    private(set) var FlipsCount = 0 {
        didSet {
            FlipsCountLabel.text = "Flips: \(FlipsCount)"
        }
    }
    @IBOutlet private weak var FlipsCountLabel: UILabel!
    
    @IBOutlet private var Buttons: [UIButton]!
    
    @IBAction private func Touch(_ sender: UIButton) {
        FlipsCount += 1
        if let cardNumber = Buttons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    private func updateViewFromModel() {
        for index in Buttons.indices {
            let button = Buttons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.04538190365, green: 1, blue: 0.724909246, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
    }
    
    private var emojiChoices = ["👻", "🎃", "😈", "😱", "🤯", "👾", "💀", "🍭"]
    
    private var emoji = [Int: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil , emojiChoices.count > 0 {
            let randomIndex = Int.random(in: 0..<emojiChoices.count)
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
}

//let vc = ViewController()
//
// vc.Buttons = blablabla
//
//let button: UIButton = xxxxx
//
//vc.Touch(button)

