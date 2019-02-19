//
//  CardBehavior.swift
//  PlayingCard
//
//  Created by 总受 on 2019/2/19.
//  Copyright © 2019 com.zeu. All rights reserved.
//

import UIKit

class CardBehavior: UIDynamicBehavior {
    lazy var colliionBehavior: UICollisionBehavior = {
        let behavior = UICollisionBehavior()
        behavior.translatesReferenceBoundsIntoBoundary = true
        return behavior
    }()
    
    lazy var itemBehavior: UIDynamicItemBehavior = {
        let behavior = UIDynamicItemBehavior()
        behavior.allowsRotation = false
        behavior.elasticity = 1.0
        behavior.resistance = 0
        return behavior
    }()
    
    private func push(_ item: UIDynamicItem) {
        let push = UIPushBehavior(items: [item], mode: .instantaneous)
        if let referenceBounds = dynamicAnimator?.referenceView?.bounds {
            let center = CGPoint(x: referenceBounds.midX, y: referenceBounds.midY)
            switch (item.center.x, item.center.y) {
            case let (x, y) where x < center.x && y < center.y:
                push.angle = CGFloat.random(in: 0...CGFloat.pi / 2)
            case let (x, y) where x > center.x && y < center.y:
                push.angle = CGFloat.random(in: 0...(CGFloat.pi - CGFloat.pi / 2))
            case let (x, y) where x < center.x && y > center.y:
                push.angle = CGFloat.random(in: -CGFloat.pi / 2...0)
            case let (x, y) where x > center.x && y > center.y:
                push.angle = CGFloat.random(in: 0...(CGFloat.pi + CGFloat.pi / 2))
            default:
                push.angle = CGFloat.random(in: 0...CGFloat.pi * 2)
            }
        }
        push.magnitude = CGFloat.random(in: 1...2)
        push.action = { [unowned push, weak self] in
            self?.removeChildBehavior(push)
        }
        addChildBehavior(push)
    }
    
    func addItem(_ item: UIDynamicItem) {
        colliionBehavior.addItem(item)
        itemBehavior.addItem(item)
        push(item)
    }
    
    func removeItem(_ item: UIDynamicItem) {
        colliionBehavior.removeItem(item)
        itemBehavior.removeItem(item)
    }
    
    override init() {
        super.init()
        addChildBehavior(colliionBehavior)
        addChildBehavior(itemBehavior)
    }
    
    convenience init(in animator: UIDynamicAnimator) {
        self.init()
        animator.addBehavior(self)
    }
}
