//What the heck are all those methods in AppDelegate.swift?

//Not running -> Foreground(Inactive <-> Active) <-> Background(Background) <-> Suspended -> Not running

//Foreground(Inactive): Running your code, but no UI events.
//Foreground(Active): Running your code, receiving and processing UI events.
//Background(Background): Running your code for a limited time, no UI events.
//Suspended: Your code not running. You could be killed.(notice no code runs between suspended and killed)

//Not running -> Foreground(Inactive)
//Your AppDelegate will receive …
//  func application(UIApplication, will/didFinishLaunchingWithOptions:[UIApplicationLaunchOptionsKey:Any]? = nil)
//… and you can observe …
//  UIApplicationDidFinishLaunching
//The passed dictionary (also in notification.userInfo)
//tells you why your application was launched.
//Some examples …
//Someone wants you to open a URL
//You entered a certain place in the world
//You are continuing an activity started on another device
//A notification arrived for you (push or local)
//Bluetooth attached device wants to interact with you
//It used to be that you would build your UI here.
//For example, you’d instantiate a split view controller and put a navigation controller inside, then push your actual content view controller.
//But nowadays we use storyboards for all that.
//So often you do not implement this method at all.

//Foreground(Inactive <- Active)
//func applicationWillResignActive(UIApplication)
//UIApplicationWillResignActive
//You will want to “pause” your UI here.
//For example, Asteroids would want to pause the asteroids.
//This might happen because a phone call comes in.
//Or you might be on your way to the background.

//Foreground(Inactive -> Active)
//func applicationDidBecomeActive(UIApplication)
//UIApplicationDidBecomeActive
//If you have “paused” your UI previously here’s where you would reactivate things.

//Foreground(Inactive) -> Background
//func applicationDidEnterBackground(UIApplication)
//UIApplicationDidEnterBackground
//Here you want to (quickly) batten down the hatches.
//You only get to run for 30s or so.
//You can request more time, but don’t abuse this(or the system will start killing you instead).
//Prepare yourself to be eventually killed here(probably won’t happen, but be ready anyway).

//Background -> Foreground(Inactive)
//func applicationWillEnterForeground(UIApplication)
//UIApplicationWillEnterForeground
//Whew! You were not killed from background state!
//Time to un-batten the hatches.
//Maybe undo what you did in DidEnterBackground.
//You will likely soon be made Active.

//UIApplicationDelegate

//Other AppDelegate items of interest …
//State Restoration (saving the state of your UI so that you can restore it even if you are killed).
//Data Protection (files can be set to be protected when a user’s device’s screen is locked).
//Open URL (in Xcode’s Info tab of Project Settings, you can register for certain URLs).
//Background Fetching (you can fetch and receive results while in the background).

//UIApplication

//Shared instance
//There is a single UIApplication instance in your application
//let myApp = UIApplication.shared
//It manages all global behavior
//You never need to subclass it
//It delegates everything you need to be involved in to its UIApplicationDelegate
//However, it does have some useful functionality …

//Opening a URL in another application
//func open(URL)
//func canOpenURL(URL) -> Bool

//Registering to receive Push Notifications
//func (un)registerForRemoteNotifications()
//Notifications, both local and push, are handled by the UNNotification framework.

//Setting the fetch interval for background fetching
//You must set this if you want background fetching to work …
//func setMinimumBackgroundFetchInterval(TimeInterval)
//Usually you will set this to UIApplicationBackgroundFetchIntervalMinimum

//Asking for more time when backgrounded
//func beginBackgroundTask(withExpirationHandler: (() -> Void)?) -> UIBackgroundTaskIdentifier
//Do NOT forget to call endBackgroundTask(UIBackgroundTaskIdentifier) when you’re done!

//Turning on the “network in use” spinner (status bar upper left)
//var isNetworkActivityIndicatorVisible: Bool // unfortunately just a Bool, be careful

//Finding out about things
//var backgroundTimeRemaining: TimeInterval { get } // until you are suspended
//var preferredContentSizeCategory: UIContentSizeCategory { get } // big fonts or small fonts
//var applicationState: UIApplicationState { get } // foreground, background, active

//Info.plist

//Many of your application’s settings are in Info.plist
//You can edit this file (in Xcode’s property list editor) by clicking on Info.plist
//Or you can even edit it as raw XML
//But usually you edit Info.plist settings by clicking on your project in the Navigator

//Capabilities

//Some features require enabling
//These are server and interoperability features
//Like iCloud, Game Center, etc.

//Switch on in Capabilities tab
//Inside your Project Settings

//Not enough time to cover these!
//But check them out!
//Many require full Developer Program membership
//Familiarize yourself with their existence
