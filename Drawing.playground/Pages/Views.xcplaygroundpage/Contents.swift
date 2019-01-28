import UIKit

//a view(UIView subclass) represents a rectangular area
//a rectangle on screen that defines a coordinate
//for drawing and for handling touch events

//Hierarchical
//a view has only one superview... var superviw: UIView?
//can have many(or zero) subviews... var subview: [UIView]

//Initializing a UIView
class SubClassOfUIView: UIView {
    // initializer if the UIView is created in code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // initializer if the UIView comes out of a storyboard
    required init?(coder aDecoder: NSCoder) { //a required, failable initializer
        super.init(coder: aDecoder)
        setup()
    }
        
    //if need an initializer, implement them both
    func setup() { }
}

let view = SubClassOfUIView()


//how to draw

//CG stands for Core GRaphics, is the underlying drawing system for normal 2D drawing in iOS

// CGFloat
//always use this instead of Double or Float for anything to do with a UIView's coordinate system
//can convert to/from a Double or Float using initializers,e.g.,let cgf = CGFloat(a Double)

// CGPoint
//a struct with two CGFloat in it: x and y
var point = CGPoint(x: 37.0, y: 55.2)
point.y = 30
point.x += 20

// CGSize
//a struct with two CGFloat in it: width and height
var size = CGSize(width: 100.0, height: 50.0)
size.width += 42.5
size.height += 75

// CGRect
// a stuct with a CGPoint and a CGSize in it
struct ExampleCGRect {
    var origin: CGPoint
    var size: CGSize
}
var rect = CGRect(origin: point, size: size) //there are other inits an well

var minX: CGFloat = rect.minX
var midY: CGFloat = rect.midY

let otherRect = CGRect(x: 40, y: 60, width: 50, height: 50)

rect.intersects(otherRect)
rect.intersection(otherRect)
rect.contains(CGPoint(x: 50, y: 50))

// View Coordinate System
//Origin is upper left
//Units are points, not pixels,most of the time there are 2 pixels per point
//The boundaries of where drawing happens
view.bounds //a view's internal drawing space's origin and size
view.center //the center of a UIView in its superview's coordinate system
view.frame //the rect containing a UIView in its superview's coordinate system

//creat a UIView
let labelRect = CGRect(x: 20, y: 20, width: 100, height: 50)
let label = UILabel(frame: labelRect) //UILabel is a subclass of UIView
label.text = "Hello"
view.addSubview(label)

//To draw, just creat a UIView subclass and override draw(CGRect)
class AnotherSubClassOfUIView: UIView {
    override func draw(_ rect: CGRect) { }
}

//Never call draw(CGRect)
//instead, if view needs to be redrawn, let the system know that calling...
view.setNeedsDisplay()
view.setNeedsDisplay(rect)

//implement the draw
//1.get a drawing context and tell it what to draw
//2.create a path of drawing using UIBezierPath alss

//Core Graphics Concepts
//1.get a context,the function UIGraphicsGetCurrentContext() gives a contxt
//2.create paths
//3.set drawing attributes like colors
//4.stroke or fill the above-create paths with the given attributes

//UIBezierPath, Defining a Path(triangle)
let path = UIBezierPath() //create a UIBezierPath


path.move(to: CGPoint(x: 80, y: 50)) //move around, add lines or arcs to the path
path.addLine(to: CGPoint(x: 140, y: 150))
path.addLine(to: CGPoint(x: 10, y: 150))

path.close() //close the path if you want

UIColor.green.setFill() //set attributes and stroke/fill
UIColor.red.setStroke()
path.lineWidth = 3.0
path.fill()
path.stroke()

//can also draw common shapes with UIBezierPath
let roundedRect = UIBezierPath(roundedRect: rect, cornerRadius: 10)
let oval = UIBezierPath(ovalIn: rect)

//clipping your drawing to a UIBezierPath's path
roundedRect.addClip()
//clip to a rounded rect to enforce the edges of a playing card

//Hit detection
path.contains(point) //return whether the point is inside the path, and the path must be closed

// UIColor
view.backgroundColor

let semitransparentYellow = UIColor.yellow.withAlphaComponent(0.5) //can have alpha(transparency)
//Alpha is between 0.0(fully transparent) and 1.0(fully opaque)
var opaque = false //let system know that you want to draw in your view with transparency
view.alpha //makr entire UIView transparent

//completely hiding a view without removing it from hierarchy
view.isHidden

// Drawing Text
//use UILabel
//to draw in drae(CGRect), use NSAttributedString
let text = NSAttributedString(string: "hello")
text.draw(at: point) //or draw(in: CGRect)
let textSize: CGSize = text.size()

// Range of characters in a NSAttributedString
let pizzaJoint = "cafe pesto"
var attrString = NSMutableAttributedString(string: pizzaJoint)
let firstWordRange = pizzaJoint.startIndex..<pizzaJoint.firstIndex(of: " ")!
let nsrange = NSRange(firstWordRange, in: pizzaJoint) //convert Range<String.Index>
attrString.addAttribute(.strokeColor, value: UIColor.orange, range: nsrange)


// Font
UIFont.TextStyle.headline
UIFont.TextStyle.body
UIFont.TextStyle.footnote
let font = UIFont(name: "Helvetica", size: 36.0)
//get metrics for the text style you want and scale font to the user's desired size
let metrics = UIFontMetrics(forTextStyle: .body)
let fontToUse = metrics.scaledFont(for: font!)


// Drawing Images
// UIImageView

//draw image inside draw(CGRect)
let image: UIImage? = UIImage(named: "foo") //it's an optional
//add foo.jpg to project in the Assets.xcassets file

//create one from files in the file system
let image2: UIImage? = UIImage(contentsOfFile: "temp/image")
let data = Data()
let image3: UIImage? = UIImage(data: data) // raw jpg, png

let image4 = UIImage()
image4.draw(at: point)
image4.draw(in: rect)
image4.drawAsPattern(in: rect) //tiles the image into aCGRect


// When bounds change
var contenMode: UIView.ContentMode = UIView.ContentMode.left
//place the bits(intact) somewhere
UIView.ContentMode.left
UIView.ContentMode.right
UIView.ContentMode.bottom
UIView.ContentMode.topRight
UIView.ContentMode.topLeft
UIView.ContentMode.bottomRight
UIView.ContentMode.bottomLeft
UIView.ContentMode.center
//scale the "bits" of the view
UIView.ContentMode.scaleToFill
UIView.ContentMode.scaleAspectFill
UIView.ContentMode.scaleAspectFit
UIView.ContentMode.redraw

// about subviews on a bounds change
// use Autolayout constraints
//or override
class OtherSubClassOfUIView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //reposition subviews's frames based on new bounds
    }
}


