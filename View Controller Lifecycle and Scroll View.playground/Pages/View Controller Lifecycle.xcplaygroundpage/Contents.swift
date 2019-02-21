import UIKit

//Keeping track of what’s happening in your Controller as it goes through its lifetime

//Creation.
//Preparation if being segued to.
//Outlet setting.
//Appearing and disappearing.
//Geometry changes.
//Low-memory situations.

class viewController: UIViewController {

//   Primary Setup
    override func viewDidLoad() {
        super.viewDidLoad() // always let super have a chance in lifecycle methods
        // do the primary setup of my MVC here
        // good time to update my View using my Model, for example, because my outlets are set
    }
//    Do not do geometry-related setup here, bounds are not yet set.
    
//    Will Appear
//    This method will be sent just before your MVC appears (or re-appears) on screen …
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // catch my View up to date with what went on while I was off-screen
    }
//    Note that this method can be called repeatedly (vs. viewDidLoad which is only called once).
    
//    Did Appear
//    You also find out after your MVC has finished appearing on screen …
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // maybe start a timer or an animation or start observing something (e.g. GPS position)?
    }

//    Will Disappear
//    Your MVC is still on screen, but it’s about to go off screen.
//    Maybe the user hit “back” in a UINavigationController
//    Or they switched to another tab in a UITabBarController
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // often you undo what you did in viewDidAppear
        // for example, stop a timer that you started there or stop observing something
    }
    
//    Did Disappear
//    Your MVC went off screen.
//    Somewhat rare to do something here, but occasionally you might want to “clean up” your MVC.
//    For example, you could save some state or release some large, recreatable resource.
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // clean up MVC
    }
    
//    Geometry
//    You get notified when your top-level view’s bounds change (or otherwise needs a re-layout).
//    In other words, when it receives layoutSubviews, you get to find out (before and after).
    override func viewWillLayoutSubviews() { }
    override func viewDidLayoutSubviews() { }
//    Usually you don’t need to do anything here because of Autolayout.
//    But if you do have geometry-related setup to do, this is the place to do it (not in viewDidLoad!).
    
//    Autorotation
//    When your device rotates, there’s a lot going on.
    override func viewWillTransition(
        to size: CGSize,
        with coordinator: UIViewControllerTransitionCoordinator
        ) { }
    
//    Low Memory
//    It is rare, but occasionally your device will run low on memory.
//    This usually means a buildup of very large videos, images or maybe sounds.
//    If your app keeps strong pointers to these things in your heap, you might be able to help!
//    When a low-memory situation occurs, iOS will call this method in your Controller …
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // stop pointing to any large-memory things (i.e. let them go from my heap)
        // that I am not currently using (e.g. displaying on screen or processing somehow)
        // and that I can recreate as needed (by refetching from network, for example)
    }
//    If your application persists in using an unfair amount of memory, you can get killed by iOS
    
//    Waking up from an storyboard
//    This method is sent to all objects that come out of a storyboard (including your Controller) …
    override func awakeFromNib() {
        super.awakeFromNib()
        // can initialize stuff here, but it’s VERY early
        // it happens way before outlets are set and before you’re prepared as part of a segue
    }
//    This is pretty much a place of last resort.
//    Use the other View Controller Lifecycle methods first if at all possible.
//    It’s primarily for situations where code has to be executed VERY EARLY in the lifecycle.
    
//    Summary
//    Instantiated (from storyboard usually)
//    awakeFromNib (only if instantiated from a storyboard)
//    segue preparation happens
//    outlets get set
//    viewDidLoad
//    These pairs will be called each time your Controller’s view goes on/off screen …
//          viewWillAppear and viewDidAppear
//          viewWillDisappear and viewDidDisappear
//    These “geometry changed” methods might be called at any time after viewDidLoad …
//          viewWillLayoutSubviews and viewDidLayoutSubviews
//    At any time, if memory gets low, you might get …
//          didReceiveMemoryWarning
    
}
