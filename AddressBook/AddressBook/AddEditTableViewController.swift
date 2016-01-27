// AddEditTableViewController.swift
// Manages editing an existing contact or editing a new one.
import CoreData
import UIKit

// MasterViewController and DetailViewController conform to this
// to be notified when a contact is added or edited, respectively
protocol AddEditTableViewControllerDelegate {
    func didSaveContact(controller: AddEditTableViewController)
}

class AddEditTableViewController: UITableViewController, 
    UITextFieldDelegate {
    @IBOutlet var inputFields: [UITextField]!

    // field names used in loops to get/set Contact attribute values via 
    // NSManagedObject methods valueForKey and setValue
    private let fieldNames = ["firstname", "lastname", "email",
        "phone", "street", "city", "state", "zip"]
    
    var delegate: AddEditTableViewControllerDelegate?
    var contact: Contact? // Contact to add or edit
    var editingContact = false // differentiates adding/editing
    
    // called when AddEditTableViewController about to appear on screen
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        // listen for keyboard show/hide notifications
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "keyboardWillShow:",
            name: UIKeyboardWillShowNotification,
            object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "keyboardWillHide:",
            name: UIKeyboardWillHideNotification,
            object: nil)
    }
    
    // called when AddEditTableViewController about to disappear
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // unregister for keyboard show/hide notifications
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // if editing an existing Contact, display its info
    override func viewDidLoad() {
        super.viewDidLoad()

        // set AddEditTableViewController as the UITextFieldDelegate
        for textField in inputFields {
            textField.delegate = self
        }
        
        // if editing a Contact, display its data
        if editingContact {
            for i in 0..<fieldNames.count {
                // query Contact object with valueForKey
                if let value: AnyObject =
                    contact?.valueForKey(fieldNames[i]) {
                    inputFields[i].text = value.description
                }
            }
        }
    }
    
    // called when app receives UIKeyboardWillShowNotification
    func keyboardWillShow(notification: NSNotification) {
        let userInfo = notification.userInfo!
        let frame = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue!
        let size = frame.CGRectValue().size // keyboard's size
        
        // get duration of keyboard's slide-in animation
        let animationTime =
            userInfo[UIKeyboardAnimationDurationUserInfoKey]!.doubleValue
        
        // scroll self.tableView so selected UITextField above keyboard
        UIView.animateWithDuration(animationTime) {
            var insets = self.tableView.contentInset
            insets.bottom = size.height
            self.tableView.contentInset = insets
            self.tableView.scrollIndicatorInsets = insets
        }
    }

    // called when app receives UIKeyboardWillHideNotification
    func keyboardWillHide(notification: NSNotification) {
        var insets = self.tableView.contentInset
        insets.bottom = 0
        self.tableView.contentInset = insets
        self.tableView.scrollIndicatorInsets = insets
    }
    
    // hide keyboard if user touches Return key
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // called to notify delegate to store changes in the model
    @IBAction func saveButtonPressed(sender: AnyObject) {
        // ensure that first name and last name UITextFields are not empty
        if inputFields[0].text!.isEmpty || inputFields[1].text!.isEmpty {
            // create UIAlertController to display error message
            let alertController = UIAlertController(title: "Error",
                message: "First name and last name are required",
                preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK",
                style: UIAlertActionStyle.Cancel, handler: nil)
            alertController.addAction(okAction)
            presentViewController(alertController, animated: true,
                completion: nil)
        } else {
            // update the Contact using NSManagedObject method setValue
            for i in 0..<fieldNames.count {
                let value = (!inputFields[i].text!.isEmpty ?
                    inputFields[i].text : nil)
                self.contact?.setValue(value, forKey: fieldNames[i])
            }
            
            self.delegate?.didSaveContact(self)
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



