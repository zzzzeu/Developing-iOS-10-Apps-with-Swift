import CoreData

//Database
//Sometimes you need to store large amounts of data locally in a database.
//And you need to search through it in an efficient, sophisticated manner.

//Enter Core Data
//Object-oriented database.
//Very, very powerful framework in iOS (unfortunately no time to cover it this quarter).

//It’s a way of creating an object graph backed by a database
//Usually backed by SQL (but also can do XML or just in memory).

//How does it work?
//Create a visual mapping (using Xcode tool) between database and objects.
//Create and query for objects using object-oriented API.
//Access the “columns in the database table” using vars on those objects.

//So how do you access all of this stuff in your code?
//Core Data is access via an NSManagedObjectContext.
//It is the hub around which all Core Data activity turns.
//The code that the Use Core Data button adds creates one for you in your AppDelegate.

//What does it look like to create/update objects in the database?
//It looks a lot like accessing normal Swift objects …
let context = NSManagedObjectContext()
//if let tweet = Tweet(context: context) {
//    tweet.text = “140 characters of pure joy”
//    tweet.created = Date()
//    let joe = TwitterUser(context: tweet.managedObjectContext)
//    tweet.tweeter = joe
//    tweet.tweeter.name = “Joe Schmo”
//}

//Deleting objects
//context.delete(tweet)

//Saving changes
//You must explicitly save any changes to a context, but note that this throws.
do {
    try context.save()
} catch {
    // deal with error
}

//Searching for objects in the database
//Let’s say we want to query for all TwitterUsers ...
//let request: NSFetchRequest<TwitterUser> = TwitterUser.fetchRequest()
//    ... who have created a tweet in the last 24 hours ...
//let yesterday = Date(timeIntervalSinceNow:-24*60*60) as NSDate
//request.predicate = NSPredicate(format: “any tweets.created > %@”, yesterday)
//    ... sorted by the TwitterUser’s name ...
//        request.sortDescriptors = [NSSortDescriptor(key: “name”, ascending: true)]
//let context: NSManagedObjectContext = ...
//let recentTweeters = try? context.fetch(request)
//Returns an empty Array (not nil) if it succeeds and there are no matches in the database.
//Returns an Array of NSManagedObjects (or subclasses thereof) if there were any matches.
//And obviously the try fails if the fetch fails.

