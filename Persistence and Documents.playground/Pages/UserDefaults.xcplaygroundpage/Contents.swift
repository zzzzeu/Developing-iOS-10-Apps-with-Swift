import Foundation
//UserDefaults is essentially a very tiny database that persists between launchings of your app.

//only stores Property List data
//A Property List is any combo of Array, Dictionary, String, Date, Data or a number (Int, etc.)

//It’s “core” functionality is simple. It just stores and retrieves Property Lists by key …
    func set(_: Any?, forKey: String) { } // the Any has to be a Property List (or crash)
    func object(forKey: String) -> Any? { return nil } // the Any is guaranteed to be a Property List

//Reading and Writing
//You don’t usually create one of these databases with UserDefaults().
//Instead, you use the static (type) var called standard …
    let defaults = UserDefaults.standard
//Setting a value in the database is easy since the set method takes an Any?.
    defaults.set(3.1415, forKey: "pi") // 3.1415 is a Double which is a Property List type
    defaults.set([1,2,3,4,5], forKey: "My Array") // Array and Int are both Property Lists
    defaults.set(nil, forKey: "Some Setting") // removes any data at that key
//You can pass anything as the first argument as long as it’s a combo of Property List types.
//UserDefaults also has convenience API for getting many of the Property List types.
    func double(forKey: String) -> Double { return 0 }
    func array(forKey: String) -> [Any]? { return [] }// returns nil if non-Array at that key
    func dictionary(forKey: String) -> [String: Any]? { return [:] }// note that keys in return are Strings
//The Any in the returned values will, of course, be a Property List type.
//
//Saving the database
//Your changes will be occasionally autosaved.
//But you can force them to be saved at any time with synchronize …
    if !defaults.synchronize() { } // failed! but not clear what you can do about it
//(it’s not “free” to synchronize, but it’s not that expensive either)

