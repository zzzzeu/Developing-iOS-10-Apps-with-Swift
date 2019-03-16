import Foundation
//There are two mechanisms for making ANY object persistent

//1.NSCoder (old) mechanism
//Requires all objects in an object graph to implement these two methods …
class Model: Codable {
    var value: Int = 3
    
    func encode(with aCoder: NSCoder) { }
    init(coder: NSCoder) {
        
    }
    init() {
        
    }
    
//    required init(from decoder: Decoder) throws {
//
//    }
//
//    func encode(to encoder: Encoder) throws {
//
//    }
}

//2.Codable (new) mechanism
//Also is essentially a way to store all the vars of an object into a dictionary.
//To do this, all the objects in the graph of objects you want to store must implement Codable.
//Some of the standard types (that you’d recognize) that are automatically Codable by Swift …
//  String, Bool, Int, Double, Float
//  Optional
//  Array, Dictionary, Set, Data
//  URL
//  Date, DateComponents, DateInterval, Calendar
//  CGFloat, AffineTransform, CGPoint, CGSize, CGRect, CGVector
//  IndexPath, IndexSet
//  NSRange
//Once your object graph is all Codable, you can convert it to either JSON or a Property List.
let object = Model()
let jsonData: Data? = try? JSONEncoder().encode(object)
//Note that this encode throws. You can catch and find errors easily (next slide).
//By the way, you can make a String object out of this Data like this …
let jsonString = String(data: jsonData!, encoding: .utf8) // JSON is always utf8
//To get your object graph back from the JSON …
if let myObject: Model = try? JSONDecoder().decode(Model.self, from: jsonData!) {
}
//JSON is not “strongly typed.” So things like Date or URL are just strings.
//Swift handles all this automatically and is even configurable, for example …
let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .iso8601 // or .secondsSince1970, etc.

//Here’s what it might look like to catch errors during a decoding.
//The thing decode throws is an enum of type DecodingError.
//Note how we can get the associated values of the enum similar to how we do with switch.
do {
    let object = try JSONDecoder().decode(Model.self, from: jsonData!)
    // success, do something with object
} catch DecodingError.keyNotFound(let key, let context) {
    print("couldn’t find key \(key) in JSON: \(context.debugDescription)")
} catch DecodingError.valueNotFound(let type, let context) {
} catch DecodingError.typeMismatch(let type, let context) {
} catch DecodingError.dataCorrupted(let context) {
}

//Codable Example
//So how do you make your data types Codable? Usually you just say so …
struct MyType: Codable {
    var someDate: Date
    var someString: String
//    var other: SomeOtherType // SomeOtherType has to be Codable too!
}
//If your vars are all also Codable (standard types all are), then you’re done!
//The JSON for this might look like ..
//{
//    "someDate": "2017-11-05T16:30:00Z",
//    "someString": "Hello",
//    "other" : <whatever SomeOtherType looks like in JSON>
//}
//Sometimes JSON keys might have different names than your var names (or not be included).
//For example, someDate might be some_date.
//You can configure this by adding a private enum to your type called CodingKeys like this …
struct MyType2: Codable {
    var someDate: Date
    var someString: String
//    var other: SomeOtherType // SomeOtherType has to be Codable too!
    private enum CodingKeys : String, CodingKey {
        case someDate = "some_date"
        case someString
        // note that the someString var will now not be included in the JSON
//        case other // this key is also called “other” in JSON
    }
}
//You can participate directly in the decoding by implementing the decoding initializer …
struct MyType3: Codable {
    var someDate: Date
    var someString: String
//    var other: SomeOtherType // SomeOtherType has to be Codable too!
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        someDate = try container.decode(Date.self, forKey: .someDate)
        someString = try container.decode(String.self, forKey: .someString)
        // process rest of vars, perhaps validating input, etc. …
//        let superDecoder = try container.superDecoder()
//        try super.init(from: superDecoder) // only if class
    }
}
struct MyType4: Codable {
    var someDate: Date
    var someString: String
//    var other: SomeOtherType // SomeOtherType has to be Codable too!
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        // there are other containers too (e.g. an unkeyed (i.e. array) container) …
        try container.encode(someDate, forKey: .someDate)
        // encode the rest of vars, perhaps transforming them, etc. …
    }
}
