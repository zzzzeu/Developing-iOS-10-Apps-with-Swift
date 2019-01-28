//a view(UIView subclass) represents a rectangular area
//a rectangle on screen that defines a coordinate
//for drawing and for handling touch events

//Hierarchical
//a view has only one superview... var superviw: UIView?
//can have many(or zero) subviews... var subview: [UIView]

//Initializing a UIView

init(frame: CGRect) // initializer if the UIView is created in code
init(coder: NSCoder) // initializer if the UIView comes out of a storyboard

//if need an initializer, implement them both
func setup() { }
override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
}
required init?(coder aDecoder: NSCoder) { //a required, failable initializer
    super.init(coder: aDecoder)
    setup()
}


//how to draw

//CG stands for Core GRaphics, is the underlying drawing system for normal 2D drawing in iOS

// CGFloat
//always use this instead of Double or Float for anything to do with a UIView's coordinate system
//can convert to/from a Double or Float using initializers,e.g.,let cgf = CGFloat(a Double)

// CGPoint
//a struct with two CGFloat in it: x and y
var point = CGFloat(x: 37.0, y: 55.2)
point.y = 30
point.x += 20

// CGSize
//a struct with two CGFloat in it: width and height
var size = CGSize(width: 100.0, height: 50.0)
size.width += 42.5
size.height += 75

// CGRect
// a stuct with a CGPoint and a CGSize in it
struct CGRect {
    var origin: CGPoint
    var size: CGSize
}
let rect = CGRect(origin: aCGPoint, size: aCGSize) //there are other inits an well

var minX: CGFloat
var midY: CGFloat
intersects(CGRect) -> Bool
intersect(CGRect)
contains(CGPoint) -> Bool

// View Coordinate System
//Origin is upper left
//Units are points, not pixels,most of the time there are 2 pixels per point
//The boundaries of where drawing happens
var bounds: CGRect //a view's internal drawing space's origin and size

var center: CGPoint //the center of a UIView in its superview's coordinate system
var frame: CGRect //the rect containing a UIView in its superview's coordinate system

//creat a UIView
let labelRect = CGRect(x: 20, y: 20, width: 100, height: 50)
let label = UILabel(frame: labelRect) //UILabel is a subclass of UIView
label.text = "Hello"
view.addSubview(label)

//To draw, just creat a UIView subclass and override draw(CGRect)
override func draw(_ rect: CGRect)

//Never call draw(CGRect)
//instead, if view needs to be redrawn, let the system know that calling...
setNeedsDisplay()
setNeedsDisplay(_ rect: CGRect)

//implement the draw
//1.get a drawing context and tell it what to draw
//2.create a path of drawing using UIBezierPath alss

//Core Graphics Concepts
//1.get a context,the function UIGraphicsGetCurrentContext() gives a contxt
//2.create paths
//3.set drawing attributes like colors
//4.stroke or fill the above-create paths with the given attributes

//UIBezierPath, Defining a Path(triangle)
let path = UIBezierPath //create a UIBezierPath

path.move(to: CGPoint(80, 50)) //move around, add lines or arcs to the path
path.addLine(to: CGPoint(140, 150))
path.addLine(to: CGPoint(10, 150))

path.colse() //close the path if you want

UIColor.green.setFill() //set attributes and stroke/fill
UIColor.red.setStoke()
path.linewidth = 3.0
path.fill()
path.stroke()

//can also draw common shapes with UIBezierPath
let roundedRect = UIBezierPath(roundedRect: CGRect, cornerRadius: CGFloat)
let oval = UIBezierPath(ovalIn: CGRect)

//clipping your drawing to a UIBezierPath's path
addClip()
//clip to a rounded rect to enforce the edges of a playing card

//Hit detection
func contains(_ point: CGPoint) -> Bool //return whether the point is inside the path, and the path must be closed

// UIColor
var backgroundColor: UIColor

let semitransparentYellow = UIColor.yellow.withAlphaCompoment(0.5) //can have alpha(transparency)
//Alpha is between 0.0(fully transparent) and 1.0(fully opaque)
var opaque = false //let system know that you want to draw in your view with transparency
var alpha: CGFloat //makr entire UIView transparent

//completely hiding a view without removing it from hierarchy
var isHidden: Bool

// Drawing Text
//use UILabel
//to draw in drae(CGRect), use NSAttributedString
let text = NSAttributedString(string: "hello")
text.draw(at: aCGPoint) //or draw(in: CGRect)
let textSize: CGSize = text.size

// Range of characters in a NSAttributedString
let pizzaJoint = "cafe pesto"
var attrString = NSMutableAttributedString(string: pizzaJoint)
let firstWordRange = pizzaJoint.startIndex..<pizzaJoint.indexOf(" ")!
let nsrange = NSRange(firstWordRange, in: pizzaJoint) //convert Range<String.Index>
attrString.addAttribute(.strokeColor, value: UIColor.orange, range: nsrange)


// Font
UIFontTextStyle.headline
               .body
               .footnote
let font = UIFont(name: "Helvetica", size: 36.0)
//get metrics for the text style you want and scale font to the user's desired size
let metrics = UIFontMetrics(forTextStyle: .body)
let fontToUse = metrics.scaledFont(for: font)


// Drawing Images
UIImageView

//draw image inside draw(CGRect)
let image: UIImage? = UIImage(name: "foo") //it's an optional
//add foo.jpg to project in the Assets.xcassets file

//create one from files in the file system
let image: UIImage? = UIImage(contentsOfFile: pathString)
let image: UIImage? = UIImage(data: aData) // raw jpg, png

let image: UIImage = ...
    image.draw(at point: aCGPoint)
image.draw(in rect: aCGRect)
image.drawAsPattern(in rect: aCGRect) //tiles the image into aCGRect


// When bounds change
var contenMode: UIViewContentMode
//place the bits(intact) somewhere
UIViewContentMode.left/.right/.bottom/.topRight/.topLeft/.bottomRight/.bottomLeft/.center
//scale the "bits" of the view
.scaleToFill/.scaleAspectFill/.scaleAspectFit
.redraw

// about subviews on a bounds change
// use Autolayout constraints
//or override
override func layoutSubviews() {
    super.layoutSubviews()
    //reposition subviews's frames based on new bounds
}


