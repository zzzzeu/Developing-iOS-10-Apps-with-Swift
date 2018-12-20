protocol Moveable {
    mutating func move(to point: Int)
}

class Car: Moveable {
    func move(to point: Int) { }
//    func changeOil()
}

struct Shape: Moveable {
    mutating func move(to point: Int) { }
//    func draw()
}

let prius: Car = Car()
let square: Shape = Shape()

var thingToMove: Moveable = prius
thingToMove.move(to: 1)
// thingToMove.changOil()      // error

let thingToMove2: [Moveable] = [prius, square]

func slide(_ slider: Moveable) {
    var slider = slider
    let positionToSlideTo = 1
        slider.move(to: positionToSlideTo)
}

slide(prius)
slide(square)

protocol Slippery {
    func slip(to point: Int)
}
func slipAndSlide(x: Slippery & Moveable) { }
// slipAndSlide(prius)        // error

//protocol UIScrollViewDelegate {
//    optional func scrollViewDidSroll(scrollView: UIScrollView)
//  and many more ...
//}
//class UIScrollView {
//    weak var delegate: UIScrollViewDelegate?
//}
//class MyViewController: UIViewController, UIScrollViewDelegate {
//    scrollView.delegate = self
//}
// ...and the Controller then would implement any of the protocol's methods it is interested in.

protocol Hashable: Equatable {
    var hashValue: Int { get }
}

protocol Equatable {
    static func ==(lhs: Self, rhs: Self) -> Bool
}

// Dictionary<Key: Hashable, Value>

extension Sequence {
    func contains(_ element: Element) -> Bool { return true }
    // min(), max(), filter(), map()
}
