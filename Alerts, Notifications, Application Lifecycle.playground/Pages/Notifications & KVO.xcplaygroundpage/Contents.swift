import UIKit

//Finding out what’s going on
//e.g. Keyboard appeared or Document State changed or User Font Size changed

//Notifications
//The “radio station” from the MVC slides. For Model (or global) to Controller communication.

//NotificationCenter
//Get the default “notification center” via NotificationCenter.default
//Then send it the following message if you want to “listen to a radio station” …
var observer: NSObjectProtocol? // a cookie to later “stop listening” with
//observer = NotificationCenter.default.addObserver(
//forName: Notification.Name, // the name of the radio station
//object: Any?, // the broadcaster (or nil for “anyone”)
//queue: OperationQueue? // the queue on which to dispatch the closure below
//) { (notification: Notification) -> Void in // closure executed when broadcasts occur
//    let info: Any? = notification.userInfo
    // info is usually a dictionary of notification-specific information
//}

//You can make your own radio station name with Notification.Name(String).

//Example of listening to “radio station broadcasts”
//(user can change this in Settings) ...
//let center = NotificationCenter.default
//var observer = center.addObserver(
//    forName: Notification.Name.UIContentSizeCategoryDidChange,
//    object: UIApplication.shared, // or nil
//    queue: OperationQueue.main // or nil
//) { notification in
    // re-set the fonts of objects using preferred fonts
    // or look at the size category and do something with it …
//    let c = notification.userInfo?[UIContentSizeCategory.newValueUserInfoKey]
    // c might be UIContentSizeCategorySmall, for example
//}
//center.removeObserver(observer) // when you’re done listening

//Posting a Notification
//NotificationCenter.default.post(
//    name: Notification.Name, // name of the “radio station”
//    object: Any?, // who is sending this notification (usually self)
//    userInfo: [AnyHashable:Any]? = nil // any info you want to pass to station listeners
//)
//Any closures added with addObserver will be executed.
//Either immediately on the same queue as post (if queue was nil).
//Or asynchronously by posting the block onto the queue specified with addObserver.


//KVO

//Watching the properties of NSObject subclasses
//The basic idea of KVO is to register a closure to invoke when a property value changes
//There is some “mechanism” required to make this work We’re not going to talk about that, but NSObject implements this mechanism
//Thus objects that inherit from NSObject can participate

//What’s it good for?
//Usually used by a Controller to observe either its Model or its View
//Not every property works with KVO
//A property has to be Key Value Coding-compliant to work
//There are a few properties scattered throughout the iOS frameworks that are compliant
//For example, UIView’s frame and center work with KVO
//So does most of CALayer underneath UIView
//Of course, you can make properties in your own NSObject subclasses compliant
//(though we don’t have time to talk about how to do any of that right now)
//You’re unlikely to use KVO much, but it’s something that’s good to know it exists

//How does it work?
//var observation = observed.observe(keyPath: KeyPath) { (observed, change) in
    // code to execute when the property described by keyPath changes
//}
//As long as the observation remains in the heap, the closure will stay active.
//The change argument to the closure is an NSKeyValueObservedChange.
//NSKeyValueObservedChange has the old value and the new value in it.
//The syntax for a KeyPath is \Type.property or even \Type.prop1.prop2.prop3.
//Swift can infer the Type (since that Type has to make sense for observed).

