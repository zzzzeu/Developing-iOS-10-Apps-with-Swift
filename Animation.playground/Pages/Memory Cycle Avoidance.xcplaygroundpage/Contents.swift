import UIKit

//When it is done acting on its items, it would be nice to remove it from its animator
//We can do this with the action var which takes a closure …
if let pushBehavior = UIPushBehavior(items: […], mode: .instantaneous) {
    pushBehavior.magnitude = …
        pushBehavior.angle = …
            pushBehavior.action = {
                pushBehavior.dynamicAnimator!.removeBehavior(pushBehavior)
    }
    animator.addBehavior(pushBehavior) // will push right away
}
//But the above has a memory cycle because its action captures a pointer back to itself.
//So neither the action closure nor the pushBehavior can ever leave the heap!

//You can define local variables on the fly at the start of a closure
var foo = { [x = someInstanceOfaClass, y = “hello”] in
    // use x and y here
}
//These locals can be declared weak
var foo = { [weak x = someInstanceOfaClass, y = “hello”] in
    // use x and y here, but x is now an Optional because it’s weak
}
//Or they can even be declared “unowned”
//unowned means that the reference counting system does count them (or check the count)
var foo = { [unowned x = someInstanceOfaClass, y = “hello”] in
    // use x and y here, x is not an Optional
    // if you use x here and it is not in the heap, you will crash
}

class Zerg {
    private var foo = {
        self.bar()
    }
    private func bar() { . . . }
}
//This, too, is a memory cycle. The closure assigned to foo keeps self in the heap.

class Zerg {
    private var foo = {[weak self = self] in
        self?.bar() // need Optional chaining now because weakSelf is an Optional
    }
    private func bar() { . . . }
}
//There are two different “self” variables here, one is local to the closure and is a weak Optional.
//Now the closure no longer has a strong pointer to self.
//So it is not keeping self in the heap with it.
//The cycle is broken.


//Even more dramatically, we could use unowned to break a cycle.
//The best example of this is back in our push behavior …
if let pushBehavior = UIPushBehavior(items: […], mode: .instantaneous) {
    pushBehavior.magnitude = …
        pushBehavior.angle = …
            pushBehavior.action = { [unowned pushBehavior] in
                pushBehavior.dynamicAnimator!.removeBehavior(pushBehavior)
    }
    animator.addBehavior(pushBehavior) // will push right away
}
