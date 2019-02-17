import UIKit

//Set up physics relating animatable objects and let them run until they resolve to stasis.

//Create a UIDynamicAnimator
let view = UIView()
var animator = UIDynamicAnimator(referenceView: view)

//Create and add UIDynamicBehavior instances
let gravity = UIGravityBehavior()
animator.addBehavior(gravity)
let collider = UICollisionBehavior()
animator.addBehavior(collider)

//Add UIDynamicItems to a UIDynamicBehavior
let item1: UIDynamicItem = UIView() // usually a UIView
let item2: UIDynamicItem = UIView() // usually a UIView
gravity.addItem(item1)
collider.addItem(item1)
gravity.addItem(item2)

//UIDynamicItem protocol
//Any animatable item must implement this …
//protocol UIDynamicItem {
//    var bounds: CGRect { get } // essentially the size
//    var center: CGPoint { get set } // and the position
//    var transform: CGAffineTransform { get set } // rotation usually
//    var collisionBoundsType: UIDynamicItemCollisionBoundsType { get set }
//    var collisionBoundingPath: UIBezierPath { get set }
//}
//UIView implements this protocol
//If you change center or transform while the animator is running, you must call this method in UIDynamicAnimator …
func updateItemUsingCurrentState(item: UIDynamicItem) { }

