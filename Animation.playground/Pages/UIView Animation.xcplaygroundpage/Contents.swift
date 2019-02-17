import UIKit

//Changes to certain UIView properties can be animated over time

//frame/center
//bounds (transient size, does not conflict with animating center)
//transform (translation, rotation and scale)
//alpha (opacity)
//backgroundColor

//Done with UIViewPropertyAnimator using closures

//Flipping a playing card over …

var cardIsFaceUp = true, myPlayingCardView = UIView()

UIView.transition(with: myPlayingCardView,
                  duration: 0.75,
                  options: [.transitionFlipFromLeft],
                  animations: { cardIsFaceUp = !cardIsFaceUp },
                  completion: nil)

//UIViewAnimationOptions.transitionFlipFrom{Left,Right,Top,Bottom}
