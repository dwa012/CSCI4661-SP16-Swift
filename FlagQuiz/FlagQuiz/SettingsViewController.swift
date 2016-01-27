// SettingsViewController.swift
// Manages the app's settings
import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var guessesSegmentedControl: UISegmentedControl!
    @IBOutlet var switches: [UISwitch]!

    var model: Model! // set by QuizViewController
    private var regionNames = ["Africa", "Asia", "Europe",
        "North_America", "Oceania", "South_America"]
    private let defaultRegionIndex = 3
    
    // used to determine whether any settings changed
    private var settingsChanged = false
    
    // called when SettingsViewController is displayed
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // select segment based on current number of guesses to display
        guessesSegmentedControl.selectedSegmentIndex =
            model.numberOfGuesses / 2 - 1
        
        // set switches based on currently selected regions
        for i in 0 ..< switches.count {
            switches[i].on = model.regions[regionNames[i]]!
        }
    }
    
    // update guesses based on selected segment's index
    @IBAction func numberOfGuessesChanged(sender: UISegmentedControl) {
        model.setNumberOfGuesses(2 + sender.selectedSegmentIndex * 2)
        settingsChanged = true
    }
    
    // toggle region corresponding to toggled UISwitch
    @IBAction func switchChanged(sender: UISwitch) {
        for i in 0 ..< switches.count {
            if sender === switches[i] {
                model.toggleRegion(regionNames[i])
                settingsChanged = true
            }
        }
        
        // if no switches on, default to North America and display error
        if Array(model.regions.values).filter({$0 == true}).count == 0 {
            model.toggleRegion(regionNames[defaultRegionIndex])
            switches[defaultRegionIndex].on = true
            displayErrorDialog()
        }
    }
    
    // display message that at least one region must be selected
    func displayErrorDialog() {
        // create UIAlertController for user input
        let alertController = UIAlertController(
            title: "At Least One Region Required",
            message: String(format: "Selecting %@ as the default region.",
                regionNames[defaultRegionIndex]),
            preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK",
            style: UIAlertActionStyle.Cancel, handler: nil)
        alertController.addAction(okAction)
        
        presentViewController(alertController, animated: true,
            completion: nil)
    }

    // called when user returns to quiz
    override func viewWillDisappear(animated: Bool) {
        if settingsChanged {
            model.notifyDelegate() // called only if settings changed
        }
    }
}

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

