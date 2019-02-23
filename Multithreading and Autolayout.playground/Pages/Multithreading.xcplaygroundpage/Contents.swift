import UIKit

//How to handle long-running/blocking activity (like accessing the network)

//Queues
//Multithreading is mostly about “queues” in iOS.
//Functions (usually closures) are simply lined up in a queue.
//Then those functions are pulled off the queue and executed on an associated thread(s).
//Queues can be “serial” (one closure a time) or “concurrent” (multiple threads servicing it).

//Main Queue
//There is a very special serial queue called the “main queue.”
//All UI activity MUST occur on this queue and this queue only.
//And, conversely, non-UI activity that is at all time consuming must NOT occur on that queue.
//We do this because we want our UI to be highly responsive.
//And also because we want things that happen in the UI to happen predictably (serially).
//Functions are pulled off and worked on in the main queue only when it is “quiet”.

//Global Queues
//For non-main-queue work, you’re usually going to use a shared, global, concurrent queue.

//Getting a queue
//Getting the main queue (where all UI activity must occur).
let mainQueue = DispatchQueue.main
//Getting a global, shared, concurrent “background” queue.
//This is almost always what you will use to get activity off the main queue.
let backgroundQueue = DispatchQueue.global(qos: .background)
DispatchQoS.userInteractive // high priority, only do something short and quick
DispatchQoS.userInitiated // high priority, but might take a little bit of time
DispatchQoS.background // not directly initiated by user, so can run as slow as needed
DispatchQoS.utility // long-running background processes, low priority

//Putting a block of code on the queue
//Multithreading is simply the process of putting closures into these queues.
//There are two primary ways of putting a closure onto a queue.
//You can just plop a closure onto a queue and keep running on the current queue …
//    queue.async { ... }
//    … or you can block the current queue waiting until the closure finishes on that other queue …
//    queue.sync { ... }
//We almost always do the former.

//Getting a non-global queue
//Very rarely you might need a queue other than main or global.
//Your own serial queue (use this only if you have multiple, serially dependent activities) …
let serialQueue = DispatchQueue(label: "MySerialQ")
//Your own concurrent queue (rare that you would do this versus global queues) …
let concurrentQueue = DispatchQueue(label: "MyConcurrentQ", attributes: .concurrent)

//Multithreaded iOS API
//Quite a few places in iOS will do what they do off the main queue
//They might even afford you the opportunity to do something off the main queue
//iOS might ask you for a function (a closure, usually) that executes off the main thread
//Don’t forget that if you want to do UI stuff there, you must dispatch back to the main queue

//a: if let url = URL(string: “http://stanford.edu/...”) {
//b:     let task = session.dataTask(with: url) { (data: Data?, response, error) in
//c:          // do something with the data
//d:          DispatchQueue.main.async {
//e:              // do UI stuff here
//            }
//f:          print(“did some stuff with the data, but UI part hasn’t happened yet”)
//        }
//g:      task.resume()
//    }
//h:  print(“done firing off the request for the url’s contents”)
//Summary: abghcdfe
//This is the “most likely” order.
//It’s not impossible that line e could happen before line f, for example.
