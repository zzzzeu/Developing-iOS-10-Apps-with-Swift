import UIKit
//convert it to a type that you do know to use it

class ConcentrationViewController: UIViewController {
    func flipCard() {
        //...
    }
}

let unknown: Any = ""
if let foo = unknown as? Int {
    print(foo)
}

//can cast any type with as? into any other type that make sense

let vc: UIViewController = ConcentrationViewController()
//The type of vc is UIViewController
//The assignment is legal because a ConcentrationViewController is a UIViewController
//can't say vc.flipCard(...), since vc is typed an a UIViewController

if let cvc = vc as? ConcentrationViewController {
    cvc.flipCard() //that is okay
}
