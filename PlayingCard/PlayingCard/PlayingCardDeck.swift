//
//  PlayingCardDeck.swift
//  PlayingCard
//
//  Created by 总受 on 2019/1/30.
//  Copyright © 2019 com.zeu. All rights reserved.
//

import Foundation

struct PlayingCardDeck {
     private(set) var cards = [PlayingCard]()
    
    init() {
        for suit in PlayingCard.Suit.allCases {
            for rank in PlayingCard.Rank.allCases {
                cards.append(PlayingCard(suit: suit, rank: rank))
            }
        }
    }
    
    mutating func draw() -> PlayingCard? {
        if cards.count > 0 {
            return cards.remove(at: Int.random(in: cards.indices))
        } else {
            return nil
        }
    }
}
