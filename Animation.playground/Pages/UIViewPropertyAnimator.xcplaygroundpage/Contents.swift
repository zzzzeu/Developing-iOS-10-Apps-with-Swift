import UIKit

//Easiest way to use a UIViewPropertyAnimator

//class func runningPropertyAnimator(
//    withDuration: TimeInterval,
//    delay: TimeInterval,
//    options: UIViewAnimationOptions,
//    animations: () -> Void,
//    completion: ((position: UIViewAnimatingPosition) -> Void)? = nil
//)

let myView = UIView()

if myView.alpha == 1.0 {
    UIViewPropertyAnimator.runningPropertyAnimator(
        withDuration: 3.0,
        delay: 2.0,
        options: [.allowUserInteraction],
        animations: { myView.alpha = 0.0 },
        completion: { if $0 == .end { myView.removeFromSuperview() } }
    )
    print("alpha = \(myView.alpha)")
}

//The output on the console would immediately be … alpha = 0.0 … even though the alpha on the screen won’t be zero for 5 more seconds!

//UIViewAnimationOptions
//beginFromCurrentState      // pick up from other, in-progress animations of these properties
//allowUserInteraction       // allow gestures to get processed while animation is in progress
//layoutSubviews             // animate the relayout of subviews with a parent’s animation
//repeat                     // repeat indefinitely
//autoreverse                // play animation forwards, then backwards
//overrideInheritedDuration  // if not set, use duration of any in-progress animation
//overrideInheritedCurve     // if not set, use curve (e.g. ease-in/out) of in-progress animation
//allowAnimatedContent       // if not set, just interpolate between current and end “bits”
//curveEaseInEaseOut         // slower at the beginning, normal throughout, then slow at end
//curveEaseIn                // slower at the beginning, but then constant through the rest
//curveLinear                // same speed throughout
