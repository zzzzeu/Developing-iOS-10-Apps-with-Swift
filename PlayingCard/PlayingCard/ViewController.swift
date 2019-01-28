//
//  ViewController.swift
//  PlayingCard
//
//  Created by 总受 on 2019/1/30.
//  Copyright © 2019 com.zeu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var deck = PlayingCardDeck()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1...10 {
            if let card = deck.draw() {
                print("\(card)")
            }
        }
    }


}

