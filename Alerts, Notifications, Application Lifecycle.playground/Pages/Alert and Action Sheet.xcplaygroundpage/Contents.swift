import UIKit

//Presenting a view controller to notify user of extraordinary event
//Or to make a "branching decision" in the UI
//Two kinds of "pop up and ask the user something" mechanisms

//Alerts
//Pop up in the middle of the screen.
//Usually ask questions with only two answers (e.g. OK/Cancel, Yes/No, etc.).
//Can be disruptive to your user-interface, so use carefully.
//Often used for “asynchronous” problems (“connection reset” or “network fetch failed”).
//Can have a text field to get a quick answer (e.g. password)

//Action Sheets
//Usually slides in from the bottom of the screen on iPhone/iPod Touch, and in a popover on iPad.
//Can be displayed from bar button item or from any rectangular area in a view.
//Generally asks questions that have more than two answers.
//Think of action sheets as presenting “branching decisions” to the user (i.e. what next?).

var alert = UIAlertController(
    title: "Redeploy Cassini",
    message: "Issue commands to Cassini’s guidance system.",
    preferredStyle: .actionSheet
)
alert.addAction(UIAlertAction(
    title: "Orbit Saturn",
    style: UIAlertAction.Style.default)
{ (action: UIAlertAction) -> Void in
    // go into orbit around saturn
    }
)
alert.addAction(UIAlertAction(
    title: "Explore Titan",
    style: .default)
{ (action: UIAlertAction) -> Void in
//    if !self.loggedIn { self.login() }
//      if loggedIn go to titan
    }
)
alert.addAction(UIAlertAction(
    title: "Closeup of Sun",
    style: .destructive)
{ (action: UIAlertAction) -> Void in
//    if !loggedIn { self.login() }
//      if loggedIn destroy Cassini by going to Sun
    }
)
alert.addAction(UIAlertAction(
    title: "Cancel",
    style: .cancel)
{ (action: UIAlertAction) -> Void in
    // do nothing
    }
)
let redeployBarButtonItem = UIBarButtonItem()
alert.modalPresentationStyle = .popover
let ppc = alert.popoverPresentationController
ppc?.barButtonItem = redeployBarButtonItem
//present(alert, animated: true, completion: nil)


var alert2 = UIAlertController(
    title: "Login Required",
    message: "Please enter your Cassini guidance system...",
    preferredStyle: .alert
)
alert2.addAction(UIAlertAction(
    title: "Cancel",
    style: .cancel)
{ (action: UIAlertAction) -> Void in
    // do nothing
    }
)
alert2.addAction(UIAlertAction(
    title: "Login",
    style: .default)
{ (action: UIAlertAction) -> Void in
    // get password and log in
//    if let tf = self.alert.textFields?.first {
//        self.loginWithPassword(tf.text)
//    }
    }
)
alert2.addTextField(configurationHandler: { textField in
    textField.placeholder = "Guidance System Password"
    textField.isSecureTextEntry = true
})
//present(alert2, animated: true, completion: nil)
