import UIKit

//UIGravityBehavior
var angle: CGFloat // in radians; 0 is to the right; positive numbers are clockwise
var magnitude: CGFloat // 1.0 is 1000 points/s/s

//UIAttachmentBehavior
init(item: UIDynamicItem, attachedToAnchor: CGPoint)
init(item: UIDynamicItem, attachedTo: UIDynamicItem)
init(item: UIDynamicItem, offsetFromCenter: CGPoint, attachedTo[Anchor]…)
var length: CGFloat // distance between attached things (this is settable while animating!)
var anchorPoint: CGPoint // can also be set at any time, even while animating
//The attachment can oscillate (i.e. like a spring) and you can control frequency and damping

//UICollisionBehavior
var collisionMode: UICollisionBehaviorMode // .items, .boundaries, or .everything
//If .items, then any items you add to a UICollisionBehavior will bounce off of each other
//If .boundaries, then you add UIBezierPath boundaries for items to bounce off of …
func addBoundary(withIdentifier: NSCopying, for: UIBezierPath)
func addBoundary(withIdentifier: NSCopying, from: CGPoint, to: CGPoint)
func removeBoundary(withIdentifier: NSCopying)
var translatesReferenceBoundsIntoBoundary: Bool // referenceView’s edges
//NSCopying means NSString or NSNumber, but remember you can as to String, Int, etc.
//How do you find out when a collision happens?
var collisionDelegate: UICollisionBehaviorDelegate
//… this delegate will be sent methods like …
func collisionBehavior(behavior: UICollisionBehavior,
                       began/endedContactFor: UIDynamicItem,
                       withBoundaryIdentifier: NSCopying, // with:UIDynamicItem too
                       at: CGPoint)

//UISnapBehavior
init(item: UIDynamicItem, snapTo: CGPoint)
//Imagine four springs at four corners around the item in the new spot.
//You can control the damping of these “four springs” with var damping: CGFloat

//UIPushBehavior
var mode: UIPushBehaviorMode // .continuous or .instantaneous
var pushDirection: CGVector
//… or …
var angle: CGFloat // in radians and positive numbers are clockwise
var magnitude: CGFloat // magnitude 1.0 moves a 100x100 view at 100 pts/s/s

//UIDynamicItemBehavior
//Controls the behavior of items as they are affected by other behaviors.
//Any item added to this behavior (with addItem) will be affected by …
var allowsRotation: Bool
var friction: CGFloat
var elasticity: CGFloat
//… and others
//Can also get information about items with this behavior ...
func linearVelocity(for: UIDynamicItem) -> CGPoint
func addLinearVelocity(CGPoint, for: UIDynamicItem)
func angularVelocity(for: UIDynamicItem) -> CGFloat

//UIDynamicBehavior
//Superclass of behaviors.
//You can create your own subclass which is a combination of other behaviors.
//Usually you override init method(s) and addItem and removeItem to call …
func addChildBehavior(UIDynamicBehavior) { }
//All behaviors know the UIDynamicAnimator they are part of
//They can only be part of one at a time.
var dynamicAnimator: UIDynamicAnimator? { get }
//And the behavior will be sent this message when its animator changes …
func willMove(to: UIDynamicAnimator?)

//UIDynamicBehavior’s action property
//Every time the behavior acts on items, this block of code that you can set is executed …
var action: (() -> Void)?
