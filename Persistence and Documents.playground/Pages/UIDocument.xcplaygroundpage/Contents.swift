import UIKit

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

//      UIDocumentBrowserViewController

//Managing user documents
//You probably want users to be able to easily manage their documents in a document-based app.
//Choosing files to open, renaming files, moving them, accessing iCloud drive, etc.
//The UIDocumentBrowserViewController (UIDBVC) does all of this for you.
//Using UIDocument to store your document makes leveraging this UIDBVC easy.

//It has to be the root view controller in your storyboard
//Your document-editing MVC will then be presented modally on top of (i.e. takes over the screen).

//To use the UIDBVC, you have to register which types your application uses.
//You do this in the Project Settings in the Info tab with your Target selected.
//Declaring your own document type
//You might have a custom document type that your application edits
//You can add this under Exported UTIs in the same place in Project Settings

//Opening documents at the request of other apps (including Files)
//A user can now click on a document of your type in Files (or another app can ask to open one)
//When this happens, your AppDelegate gets a message sent to it …
    func application(_: UIApplication, open: URL, options: [UIApplication.OpenURLOptionsKey:Any]) -> Bool { return true }
//We haven’t discussed the AppDelegate yet, but it’s just a swift file with some methods in it.
//Inside here, you can ask your UIDocumentBrowserViewController to show this document …
//let uidbvc = window?.rootViewController as? UIDocumentBrowserViewController // since it’s “arrowed” in storyboard
//uidbvc.revealDocument(at: URL, importIfNeeded: true) { (url, error) in
//    if error != nil {
//        // present a UIDocument at url modally (more on how to do this in a moment)
//    } else {
//        // handle the error
//    }
//}

//Xcode template
//an Xcode template exists to do all of the above configuration for us

//What is in the template?
//A stub for Document Types in Project Settings (supports public.image file types)
//The Info.plist entry Supports Document Browser = YES
//The code in AppDelegate to reveal a document
//A stubbed out UIDocument subclass (with empty contents and load(fromContents) methods)
//A stubbed out MVC to display a document (just calls UIDocument’s open and close methods)
//A subclass of UIDocumentBrowserViewController (with almost everything implemented)

//What you need to do …
//1. Use your UIDocument subclass instead of the stubbed out one
//2. Use your document-viewing MVC code (already using UIDocument) instead of stub
//3. Add code to UIDBVC subclass to …
//a. configure the UIDBVC (allow multiple selection? creation of new documents? etc.)
//b. specify the url of a template document to copy to create new documents
//c. present your document-viewing MVC modally given the url of a document
//4. Update the Document Types in Project Settings to be your types (instead of public.image)

//Step 3a: Configuring the UIDBVC
//This happens in its viewDidLoad …
//override func viewDidLoad() {
//    super.viewDidLoad()
//    delegate = self // the guts of making UIDBVC work are in its delegate methods
//    allowsDocumentCreation = true
//    allowsPickingMultipleItems = true
//    browserUserInterfaceStyle = .dark
//    view.tintColor = .white
//}

//Steps 3b: Specifying the “new document” template URL
//This happens in this UIDBVC delegate method …
//func documentBrowser(_ controller: UIDBVC,
//                     didRequestDocumentCreationWithHandler handler: @escaping (URL?, UIDBVC.ImportMode) -> Void
//    ) {
//    let url: URL? = … // where your blank, template document can be found
//        importHandler(url, .copy or .move)
//}
//Usually you would specify .copy, but you could create a new template each time and .move.
//Likely you would have some code here that creates that blank template (or ship with your app).

//Aside: Presenting an MVC without segueing
//We haven’t covered how to present MVCs in any other way except by segueing.
//So let’s cover it now!
//It’s very easy. You present a new MVC from an existing MVC using present(animated:) …
//let newVC: UIViewController = …
//    existingVC.present(newVC, animated: true) {
//        // completion handler called when the presentation completes animating
//        // (can be left out entirely if you don’t need to do anything upon completion)
//}
//The real trick is “where do I get newMVC from?”
//Answer: you get it from your storyboard using its identifier which you set in Identity Inspector
//let storyboard = UIStoryboard(name: “Main”, bundle: nil) // Main.storyboard
//if let newVC = storyboard.instantiateViewController(withIdentifier: “foo”) as? MyDocVC {
//    “prepare” newMVC and then present(animated:) it
//}

//Steps 3c: Presenting your document MVC modally
//The Xcode template stubs out a function called presentDocument(at: URL) to do this …
//func presentDocument(at url: URL) {
//    let story = UIStoryboard(name: “Main”, bundle: nil)
//    if let docvc = story.instantiateViewController(withIdentifier: “DocVC”) as? DocVC {
//        docvc.document = MyDocument(fileURL: url)
//        present(docvc, animated: true)
//    }
//}

