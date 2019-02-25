import UIKit

//Example
//Using the dashed blue lines to try to tell Xcode what you intend
//Reset to Suggested Constraints in lower right corner if blue lines were good enough
//Ctrl-dragging to the edges and to other views
//Size Inspector to look at and edit simple details of the constraints on a view
//Clicking on a constraint directly in the storyboard and inspecting it
//The “pin” menu in the lower right corner (there’s an “arrange” button there too)
//The Document Outline is an awesome place to view/edit and resolve problem constraints

//Autolayout can be done from code as well
//Search for the words “anchor” and “auto layout” in the UIView documentation.

//We can vary our UI based on its “size class”
//A view controller’s current size class says what sort of room it has to lay out in.
//It’s not an exact number or dimension, it’s just either “compact” or “regular” width or height.

//Using Size Class information
//You can find out your current “size class” in code using this method in UIViewController …
let viewController = UIViewController()
let myHorizSizeClass: UIUserInterfaceSizeClass = viewController.traitCollection.horizontalSizeClass
//The return value is an enum … either .compact or .regular (or .unspecified).
