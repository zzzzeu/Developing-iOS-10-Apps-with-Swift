import Foundation

//When to use UIDocument
//If your application stores user information in a way the user perceives as a “document”.
//If you just want iOS to manage the primary storage of user information.

//What does UIDocument do?
//Manages all interaction with storage devices (not just filesystem, but also iCloud, Box, etc.).
//Provides asynchronous opening, writing, reading and closing of files.
//Autosaves your document data.
//Makes integration with iOS 11’s new Files application essentially free.

//What do you need to do to make UIDocument work?
//Subclass UIDocument to add vars to hold the Model of your MVC that shows your “document”.
//Then implement one method that writes the Model to a Data and one that reads it from a Data.
//Now you can use UIDocument’s opening, saving and closing methods as needed.
//You can also use its “document has changed” method (or implement undo) to get autosaving

//Subclassing UIDocument
//For simple documents, there’s nothing to do here except add your Model as a var …
//  class EmojiArtDocument: UIDocument {
//      var emojiArt: EmojiArt?
//  }
//There are, of course, methods you can override, but usually you don’t need to.

//Creating a UIDocument
//Figure out where you want your document to be stored in the filesystem …
var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
url = url.appendingPathComponent("Untitled.foo")
//Instantiate your subclass by passing that url to UIDocument’s only initializer …
//let myDocument = EmojiArtDocument(fileURL: url)
//… then (eventually) set your Model var(s) on your newly created UIDocument subclass …
//      myDocument.emojiArt = …

//Creating a Data for your Model
//Override this method in your UIDocument subclass to convert your Model into a Data.
//override func contents(forType typeName: String) throws -> Any {
//    return emojiArt converted into a Data
//}
//Note that the return type is Any … that’s because your file format can also be a FileWrapper.
//A FileWrapper represents a directory full of files that make up your document

//Turning a Data into a Model
//Override this method in your UIDocument subclass to a Data into an instance of your Model.
//override func load(fromContents contents: Any, ofType typeName: String?) throws {
//    emojiArt = contents converted into an EmojiArt
//}
//Again, you can throw here if you can’t create a document from the passed contents.

//Now you can open your document (i.e. get your Model) …
//    myDocument.open { success in
//        if success {
//            // your Model var(s) (e.g. emojiArt) is/are ready to use
//        } else {
//            // there was a problem, check documentState
//        }
//}

//Saving your document
//You can let your document know that the Model has changed with this method …
//    myDocument.updateChangeCount(.done)

//Or you can force a save using this method …
//let url = myDocument.fileURL // or something else if you want “save as”
//myDocument.save(to url: URL, for: UIDocumentSaveOperation) { success in
//    if success {
//        // your Model has successfully been saved
//    } else {
//        // there was a problem, check documentState
//    }
//}
//UIDocumentSaveOperation is either .forCreating or .forOverwriting.

//Closing your document
//When you are finished using a document for now, close it …
//    myDocument.close { success in
//        if success {
//            // your Model has successfully been saved and closed
//            // use the open method again if you want to use it
//        } else {
//            // there was a problem, check documentState
//        }
//}

//Document State
//As all this goes on, your document transitions to various states.
//You can find out what state it is in using this var …
//var documentState: UIDocumentState
//Possible values …
//        .normal — document is open and ready for use!
//        .closed — document is closed and must be opened to be used
//        .savingError — document couldn’t be saved (override handleError if you want to know why)
//        .editingDisabled — the document cannot currently be edited (so don’t let your UI do that)
//        .progressAvailable — how far a large document is in getting loaded (check progress var)
//        .inConflict — someone edited this document somewhere else (iCloud)
//        To resolve conflicts, you access the conflicting versions with …
//        NSFileVersion.unresolvedConflictVersionsOfItem(at url: URL) -> [NSFileVersion]?
//        For the best UI, you could give your user the choice of which version to use.
//        Or, if your document’s contents are “mergeable”, you could even do that.
//documentState can be “observed” using the UIDocumentStateChanged notification (more later).

//Thumbnail
//You can specify a thumbnail image for your UIDocument.
//override func fileAttributesToWrite(to url: URL, for operation: UIDocumentSaveOperation)
//    throws -> [AnyHashable : Any] {
//        var attributes = try super.fileAttributesToWrite(to: url, for: saveOperation)
//        if let thumbnail: UIImage = … {
//            attributes[URLResourceKey.thumbnailDictionaryKey] =
//                [URLThumbnailDictionaryItem.NSThumbnail1024x1024SizeKey:thumbnail]
//        }
//        return attributes
//}
//It does not have to be 1024x1024 (it seems to have a minimum size, not sure what).
