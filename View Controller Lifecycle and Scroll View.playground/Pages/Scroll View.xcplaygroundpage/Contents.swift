import UIKit

//A UIView that lets you scroll around and zoom on other UIViews

var view = UIView(), logo = UIView(), scrollView = UIScrollView(), aerial = UIView()

//Adding subviews to a normal UIView ...
logo.frame = CGRect(x: 300, y: 50, width: 120, height: 180)
view.addSubview(logo)

//Adding subviews to a UIScrollView ...
scrollView.contentSize = CGSize(width: 3000, height: 2000)
logo.frame = CGRect(x: 2700, y: 50, width: 120, height: 180)
scrollView.addSubview(logo)

scrollView.contentSize = CGSize(width: 3000, height: 2000)
aerial.frame = CGRect(x: 150, y: 200, width: 2500, height: 1600)
scrollView.addSubview(aerial)

//Positioning subviews in a UIScrollView ...
aerial.frame = CGRect(x: 0, y: 0, width: 2500, height: 1600)
logo.frame = CGRect(x: 2300, y: 50, width: 120, height: 180)
scrollView.contentSize = CGSize(width: 2500, height: 1600)

//Where in the content is the scroll view currently positioned?
let upperLeftOfVisible: CGPoint = scrollView.contentOffset
//In the content area’s coordinate system.

//What area in a subview is currently visible?
let visibleRect: CGRect = aerial.convert(scrollView.bounds, from: scrollView)


//How do you create one?
//Just like any other UIView. Drag out in a storyboard or use UIScrollView(frame:).
//Or select a UIView in your storyboard and choose “Embed In -> Scroll View” from Editor menu.

var imageView = UIImageView()
//To add your “too big” UIView in code using addSubview …
if let image = UIImage(named: "bigimage.jpg") {
    let imageView = UIImageView(image: image) // iv.frame.size will = image.size
    scrollView.addSubview(imageView)
}
//Add more subviews if you want.
//All of the subviews’ frames will be in the UIScrollView’s content area’s coordinate system(that is, (0,0) in the upper left & width and height of contentSize.width & .height).

//Now don’t forget to set the contentSize
//Common bug is to do the above lines of code (or embed in Xcode) and forget to say:
scrollView.contentSize = imageView.frame.size

//Scrolling programmatically
scrollView.scrollRectToVisible(.zero, animated: true)

//The style of the scroll indicators (call flashScrollIndicators when your scroll view appears).
//Whether the actual content is “inset” from the content area (contentInset property).

//Zooming
//Zooming is also going to affect the scroll view’s contentSize and contentOffset.
//Will not work without minimum/maximum zoom scale being set
scrollView.minimumZoomScale = 0.5 // 0.5 means half its normal size
scrollView.maximumZoomScale = 2.0 // 2.0 means twice its normal size

//Will not work without delegate method to specify view to zoom
func viewForZooming(in scrollView: UIScrollView) -> UIView { return view }

//Zooming programatically
var zoomScale = CGFloat()
func setZoomScale(_: CGFloat, animated: Bool) { }
func zoom(to rect: CGRect, animated: Bool) { }

//delegate method will notify you when zooming ends
func scrollViewDidEndZooming(_ scrollView: UIScrollView,
                             with view: UIView, // from delegate method above
                             atScale: CGFloat) { }
//If you redraw your view at the new scale, be sure to reset the transform back to identity.
