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
        return (buttons.count + 1) / 2
    }
    
    private(set) var flipsCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipsCount)", attributes: attributes)
        flipsCountLabel.attributedText = attributedString
    }
    
    @IBOutlet private weak var flipsCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private var buttons: [UIButton]!
    
    @IBAction private func touch(_ sender: UIButton) {
        flipsCount += 1
        if let cardNumber = buttons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    private func updateViewFromModel() {
        for index in buttons.indices {
            let button = buttons[index]
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
    
    private var emoji = [Card: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil , emojiChoices.count > 0 {
            let randomIndex = Int.random(in: 0..<emojiChoices.count)
            emoji[card] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card] ?? "?"
    }
    
}

//let vc = ViewController()
//
// vc.Buttons = blablabla
//
//let button: UIButton = xxxxx
//
//vc.Touch(button)

