// DetailViewController.swift
// Shows the details for one Contact
import CoreData
import UIKit

// MasterViewController conforms to be notified when contact edited
protocol DetailViewControllerDelegate {
    func didEditContact(controller: DetailViewController)
}

class DetailViewController: UIViewController,
    AddEditTableViewControllerDelegate {
    
    // outlets for UITextFields that display contact data
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    
    var delegate: DetailViewControllerDelegate!
    var detailItem: Contact!
    
    // when DetailViewController is presented, display contact's data
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if detailItem != nil {
            displayContact()
        }
    }
    
    // show selected Contact's data
    func displayContact() {
        // display Contact's name in navigation bar
        self.navigationItem.title =
            detailItem.firstname + " " + detailItem.lastname

        // display other attributes if they have values
        if let email = detailItem.email {
            emailTextField.text = email
        }
        if let phone = detailItem.phone {
            phoneTextField.text = phone
        }
        if let street = detailItem.street {
            streetTextField.text = street
        }
        if let city = detailItem.city {
            cityTextField.text = city
        }
        if let state = detailItem.state {
            stateTextField.text = state
        }
        if let zip = detailItem.zip {
            zipTextField.text = zip
        }
    }
    
    // called by AddEditTableViewController when edited contact is saved
    func didSaveContact(controller:AddEditTableViewController) {
        displayContact() // update contact data on screen
        self.navigationController?.popViewControllerAnimated(true)
        delegate?.didEditContact(self)
    }
    
    // called when user taps Edit button
    override func prepareForSegue(segue: UIStoryboardSegue,
        sender: AnyObject?) {
            
        // configure destinationViewController for editing current contact
        if segue.identifier == "showEditContact" {
            let controller = (segue.destinationViewController as!
                UINavigationController).topViewController as!
                AddEditTableViewController
            controller.navigationItem.title = "Edit Contact"
            controller.delegate = self
            controller.editingContact = true
            controller.contact = detailItem
            controller.navigationItem.leftBarButtonItem =
                self.splitViewController?.displayModeButtonItem()
            controller.navigationItem.leftItemsSupplementBackButton = true
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


