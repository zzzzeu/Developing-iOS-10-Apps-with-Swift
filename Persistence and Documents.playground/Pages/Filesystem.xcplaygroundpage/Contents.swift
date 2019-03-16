import Foundation
//Your application sees iOS file system like a normal Unix filesystem
//It starts at /.
//There are file protections, of course, like normal Unix, so you can’t see everything.
//In fact, you can only read and write in your application’s “sandbox”.

//Why sandbox?
//Security (so no one else can damage your application)
//Privacy (so no other applications can view your application’s data)
//Cleanup (when you delete an application, everything it has ever written goes with it)

//So what’s in this “sandbox”?
//Application directory — Your executable, .storyboards, .jpgs, etc.; not writeable.
//Documents directory — Permanent storage created by and always visible to the user.
//Application Support directory — Permanent storage not seen directly by the user.
//Caches directory — Store temporary files here (this is not backed up by iTunes).
//Other directories (see documentation) …

//Getting a path to these special sandbox directories
//FileManager (along with URL) is what you use to find out about what’s in the file system.
//You can, for example, find the URL to these special system directories like this ...
let url: URL = FileManager.default.url(
    for: FileManager.SearchPathDirectory.documentDirectory, // for example
    in: .userDomainMask, // always .userDomainMask on iOS
    appropriateFor: nil, // only meaningful for “replace” file operations
    create: true // whether to create the system directory if it doesn’t already exist
)
//Examples of SearchPathDirectory values
//    .documentDirectory, .applicationSupportDirectory, .cachesDirectory, etc.

//              URL
//Building on top of these system paths
//URL methods:
func appendingPathComponent(_: String) -> URL { return URL(fileURLWithPath: "folder") }
func appendingPathExtension(_: String) -> URL { return URL(fileURLWithPath: "folder") } // e.g. “jpg”
//Finding out about what’s at the other end of a URL
var isFileURL: Bool = true // is this a file URL (whether file exists or not) or something else?
func resourceValues(for keys: [URLResourceKey]) throws -> [URLResourceKey:Any]? { return [:] }
//Example keys: .creationDateKey, .isDirectoryKey, .fileSizeKey

//              Data
//Reading binary data from a URL …
Data.init(contentsOf: URL(fileURLWithPath: "folder"), options: [])
//init(contentsOf: URL, options: Data.ReadingOptions) throws
//Writing binary data to a URL …
func write(to url: URL, options: Data.WritingOptions) throws -> Bool { return true }
//The options can be things like .atomic (write to tmp file, then swap) or .withoutOverwriting.
//Notice that this function throws.

//FileManager
//Provides utility operations.
//e.g., fileExists(atPath: String) -> Bool
//Can create and enumerate directories; move, copy, delete files; etc.
