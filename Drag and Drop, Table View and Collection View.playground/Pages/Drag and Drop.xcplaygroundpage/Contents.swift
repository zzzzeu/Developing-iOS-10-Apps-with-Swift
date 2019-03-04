import UIKit

//is a UIView thing
//Very interoperable way to move data around
//Multitouch allows some fingers to be doing drag and drop and other fingers working your app

//Interactions
//var view = UIView()
//let dragInteraction = UIDragInteraction(delegate: theDelegate)
//let dropInteraction = UIDropInteraction(delegate: theDelegate)
//view.addInteraction(dropInteraction)

//Starting a drag
//Now, when the user makes a dragging gesture, the delegate gets …
func dragInteraction(_ interaction: UIDragInteraction,
                     itemsForBeginning session: UIDragSession
    ) -> [UIDragItem] { return [] }
//… and can return the items it is willing to have dragged from the view.
//Returning an empty array means “don’t drag anything after all.”

//A UIDragItem is created like this …
let provider = UIColor()
let dragItem = UIDragItem(itemProvider: NSItemProvider(object: provider))
//Providers: NSAttributedString, NSString, UIImage, NSURL, UIColor, MKMapItem, CNContact.
//You can drag your own types of data, but that’s beyond the scope of this course.
//Note that some of these types start with NS … you might have to use as? to cast them.

//You can also provide an object that will be passed to drop targets inside your own app …
//dragItem.localObject = someObject

//Adding to a drag
//Even in the middle of a drag, users can add more to their drag if you implement …
func dragInteraction(_ interaction: UIDragInteraction,
                     itemsForAddingTo session: UIDragSession
    ) -> [UIDragItem] { return [] }
//… and returns more items to drag.

//Accepting a drop
//When a drag moves over a view with a UIDropInteraction, the delegate gets …
func dropInteraction(_ interaction: UIDropInteraction,
                     canHandle session: UIDragSession
    ) -> Bool { return true }
//… at which point the delegate can refuse the drop before it even gets started.
//To figure that out, the delegate can ask what kind of objects can be provided …
//let stringAvailable = session.canLoadObjects(ofClass: NSAttributedString.self)
//let imageAvailable = session.canLoadObjects(ofClass: UIImage.self)
//… and refuse the drop if it isn’t to your liking.

//If you don’t refuse it in canHandle:, then as the drag progresses, you’ll start getting …
//func dropInteraction(_ interaction: UIDropInteraction,
//                     sessionDidUpdate session: UIDragSession
//    ) -> UIDropProposal
//… to which you will respond with UIDropProposal(operation: .copy/.move/.cancel).
//    .cancel means the drop would be refused
//    .copy means drop would be accepted
//    .move means drop would be accepted and would move the item (only for drags within an app)
//If it matters, you can find out where the touch is with session.location(in: view).

//If all that goes well and the user let’s go of the drop, you get to go fetch the data …
func dropInteraction(_ interaction: UIDropInteraction,
                     performDrop session: UIDropSession
    ) { }
//You will implement this method by calling loadObjects(ofClass:) on the session.
//This will go and fetch the data asynchronously from whomever the drag source is.
//session.loadObjects(ofClass: NSAttributedString.self) { theStrings in
    // do something with the dropped NSAttributedStrings
//}
//The passed closure will be executed some time later on the main thread.
//You can call multiple loadObjects(ofClass:) for different classes.
//You don’t usually do anything else in dropInteraction(performDrop:).
