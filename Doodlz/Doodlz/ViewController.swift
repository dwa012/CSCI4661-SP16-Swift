// ViewController.swift
// Handles the UIBarButtonItems' events and motion events;
// also sets DoodleView properties when user changes settings
import UIKit

class ViewController: UIViewController, ColorViewControllerDelegate,
    StrokeViewControllerDelegate {
    @IBOutlet weak var doodleView: DoodleView!
    
    // called by ColorViewController when user changes the drawing color
    func colorChanged(color: UIColor) {
        doodleView.drawingColor = color
    }
    
    // called by StrokeViewController when user changes the stroke width
    func strokeWidthChanged(width: CGFloat) {
        doodleView.strokeWidth = width
    }
    
    // set color or stroke width before presenting view controller
    override func prepareForSegue(segue: UIStoryboardSegue,
        sender: AnyObject?) {
        // determine which segue is being performed
        if segue.identifier == "showColorChooser" {
            let destination = (segue.destinationViewController
                as! ColorViewController)
            destination.color = doodleView.drawingColor
            destination.delegate = self
        } else if segue.identifier == "showStrokeWidthChooser" {
            let destination = (segue.destinationViewController
                as! StrokeViewController)
            destination.strokeWidth = doodleView.strokeWidth
            destination.delegate = self
        }
    }
    
    // remove last Squiggle from DoodleView
    @IBAction func undoButtonPressed(sender: AnyObject) {
        doodleView.undo()
    }
    
    // confirm then clear current drawing
    @IBAction func clearButtonPressed(sender: AnyObject) {
        displayEraseDialog()
    }
    
    // displays a dialog asking for confirmation before deleting drawing
    func displayEraseDialog() {
        // create UIAlertController for user input
        let alertController = UIAlertController(title: "Are You Sure?",
            message: "Touch Delete to erase your doodle",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        // create Cancel action
        let cancelAction = UIAlertAction(title: "Cancel",
            style: UIAlertActionStyle.Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "Delete",
            style: UIAlertActionStyle.Default,
            handler: {(action) in
                self.doodleView.clear()
            })
        alertController.addAction(deleteAction)
        presentViewController(alertController, animated: true,
            completion: nil)
    }
    
    // handles shake-to-erase
    override func motionEnded(motion: UIEventSubtype,
        withEvent event: UIEvent?) {
        if motion == UIEventSubtype.MotionShake {
            displayEraseDialog()
        }
    }
        
    // display UIActivityViewController for saving, printing, sharing
    @IBAction func actionButtonPressed(sender: AnyObject) {
        let itemsToShare = ["Check out my doodle!", doodleView.image]
        let activityViewController = UIActivityViewController(
            activityItems: itemsToShare, applicationActivities: nil)
        presentViewController(activityViewController,
            animated: true, completion: nil)
    }
}

//        activityViewController.excludedActivityTypes =
//            [UIActivityTypeAssignToContact]


// if saving does not work on a device, add the following code
// to the end of method actionButtonPressed

// fixes bug that prevents devices from saving image;
// app works without this in the iOS simulator
//        if activityViewController.respondsToSelector(
//            "popoverPresentationController") {
//            let presentationController =
//                activityViewController.popoverPresentationController
//            presentationController?.sourceView = view
//        }


/*************************************************************************
* (C) Copyright 2015 by Deitel & Associates, Inc. All Rights Reserved.   *
*                                                                        *
* DISCLAIMER: The authors and publisher of this book have used their     *
* best efforts in preparing the book. These efforts include the          *
* development, research, and testing of the theories and programs        *
* to determine their effectiveness. The authors and publisher make       *
* no warranty of any kind, expressed or implied, with regard to these    *
* programs or to the documentation contained in these books. The authors *
* and publisher shall not be liable in any event for incidental or       *
* consequential damages in connection with, or arising out of, the       *
* furnishing, performance, or use of these programs.                     *
*                                                                        *
* As a user of the book, Deitel & Associates, Inc. grants you the        *
* nonexclusive right to copy, distribute, display the code, and create   *
* derivative apps based on the code. You must attribute the code to      *
* Deitel & Associates, Inc. and reference the book's web page at         *
* www.deitel.com/books/ios8fp1/. If you have any questions, please email *
* at deitel@deitel.com.                                                  *
*************************************************************************/

