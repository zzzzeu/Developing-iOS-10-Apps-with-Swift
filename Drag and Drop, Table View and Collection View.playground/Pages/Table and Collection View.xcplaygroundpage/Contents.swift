import UIKit

//Table View presents the information in a long (possibly sectioned) list.
//Collection View presents the information in a 2D format (usually “flowing” like text flows).
//They are very similar in their API

//UITableView
//It can show simple ancillary information
//    Left Detail style
//    Right Detail style
//    Basic style
//    Custom style
//    The rows can also be Grouped (but usually only when the information in the table is fixed)

//UICollectionView
//There is only “custom” layout of information.
//Like Table View, can also be divided into sections

//views are not allowed to own their data
//So we can’t just somehow set the data in some var.
//Instead, we set a var called dataSource.
//The type of the dataSource var is a protocol with methods that supply the data.

//Setting the dataSource and delegate
//In UITableView …
//var dataSource: UITableViewDataSource
//var delegate: UITableViewDelegate
//In UICollectionView …
//var dataSource: UICollectionViewDataSource
//var delegate: UICollectionViewDelegate
//these vars will want to be set to the Controller of the MVC

//The UITableView/CollectionViewDataSource protocol
//The “data retrieving” protocol has many methods.
//But these 3 are the core (UITableView abbreviated to UITV and UICollectionView to UICV) …
//UITableView
//func numberOfSections(in tableView: UITV) -> Int
//func tableView(_ tv: UITV, numberOfRowsInSection section: Int) -> Int
//func tableView(_ tv: UITV, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//UICollectionView
//func numberOfSections(in collectionView: UICV) -> Int
//func collectionView(_ cv: UICV, numberOfItemsInSection section: Int) -> Int
//func collectionView(_ cv: UICV, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell

//IndexPath specifies which row (in TV) or item (in CV) we’re talking about.
//In both, you get the section the row or item is in from indexPath.section.
//In TV, you get which row from indexPath.row; in CV you get which item from indexPath.item.
//CV might seem like rows and columns, but it’s not, it’s just items “flowing” like text.



//                         Loading up Cells
//Putting data into the UI
//func tableView(_ tv: UITV, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tv.dequeueReusableCell(withIdentifier: “MyCellId”, for: indexPath)
//}

//Cell Reuse
//When a UITableViewCell scrolls off the screen, it gets put in a pool to be reused.
//The dequeueReusableCell(withIdentifier:) method grabs one out of that reuse pool.

//Cell Creation
//How do new (non-reused) cells get created?
//They get created by copying a prototype cell you configure in your storyboard.

//Custom UITableViewCell subclass
//When we put custom UI into a UITableViewCell prototype, we probably need outlets to it.
//we have to subclass UITableViewCell and put the outlets in there.
//Then we inspect the cell in the Identity Inspector
//and change its class from UITableViewCell to MyTVC

//Implementing cellForRowAt
//func tableView(_ tv: UITV, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let prototype = decision ? “FoodCell” : “CustomFoodCell”
//    let cell = tv.dequeueReusableCell(withIdentifier: prototype, for: indexPath)
//    if let myTVCell = cell as? MyTVC {
//        myTVC.name = food(at: indexPath); myTVC.emoji = emoji(at: indexPath)
//    }
//}


//Static Table View
//Using Table View purely for UI layout
//A fantastic example of this is the iOS Settings app.
//In this case, you do not need to do any of the UITableViewDataSource stuff.
//And you can connect outlets directly to your Controller (because there’s only one of each cell).
//To do this, just set your UITableView to have Static Cells instead of Dynamic Prototypes.

//Preparing to segue from a row in a table view
//func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if let identifier = segue.identifier {
//        switch identifier {
//        case "XyzSegue": // handle XyzSegue here
//        case "AbcSegue":
//            if let cell = sender as? MyTableViewCell,
//                let indexPath = tableView.indexPath(for: cell),
//                let seguedToMVC = segue.destination as? MyVC {
//                seguedToMVC.publicAPI = data[indexPath.section][indexPath.row]
//            }
//        default: break
//        }
//    }
//}

//Seguing from Collection View cells
//func collectionView(collectionView: UICV, didSelectItemAtIndexPath indexPath: IndexPath)
//Use performSegue(withIdentifier:) from there

//What if your Model changes?
//func reloadData()
//If only part of your Model changes, there are lighter-weight reloaders, for example ...
//func reloadRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation)
//
//Controlling the height of rows in a Table View
//Row height can be fixed (UITableView’s var rowHeight: CGFloat)
//Or it can be determined using autolayout (rowHeight = UITableViewAutomaticDimension)
//If you do automatic, help the table view out by setting estimatedRowHeight to something
//The UITableView’s delegate can also control row heights …
//func tableView(UITableView, {estimated}heightForRowAt indexPath: IndexPath) -> CGFloat
//Beware: the non-estimated version of this could get called A LOT if you have a big table

//Controlling the size of cells in a Collection View
//Cell size can be fixed in the storyboard.
//You can also drive it from autolayout similar to table view.
//Or you can return the size from this delegate method …
//func collectionView(_ collectionView: UICollectionView,
//                    layout collectionViewLayout: UICollectionViewLayout,
//                    sizeForItemAt indexPath: IndexPath
//    ) -> CGSize

//Setting a header for each section
//If you have a multiple-section table view, you can set a header (or footer) for each.
//There are methods to set this to be a custom UIView.
//But usually we just supply a String for the header using this method …
//func tableView(_ tv: UITV, titleForHeaderInSection section: Int) -> String?

//Headers and footers are a bit more difficult in Collection View
//You can’t just specify them as Strings.
//First you have to “turn them on” in the storyboard.
//They are reusable (like cells are), so you have to make a UICollectionReusableView subclass.
//You put your UILabel or whatever for your header, then hook up an outlet.
//    Then you implement this dataSource method to dequeue and provide a header.
//func collectionView(_ collectionView: UICollectionView,
//                    viewForSupplementaryElementOfKind kind: String,
//                    at indexPath: IndexPath
//    ) -> UICollectionReusableView
//Use dequeueReusableSupplementaryView(ofKind:withReuseIdentifier:for:) in there.
//kind will be UICollectionElementKindSectionHeader or Footer.
