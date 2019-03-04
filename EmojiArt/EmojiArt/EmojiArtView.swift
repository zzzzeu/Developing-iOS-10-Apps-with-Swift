//
//  EmojiArtView.swift
//  EmojiArt
//
//  Created by 总受 on 2019/3/4.
//  Copyright © 2019 com.zeu. All rights reserved.
//

import UIKit

class EmojiArtView: UIView {

    var backgroundImage: UIImage? { didSet { setNeedsDisplay() } }
    
    override func draw(_ rect: CGRect) {
        backgroundImage?.draw(in: bounds)
    }

}
