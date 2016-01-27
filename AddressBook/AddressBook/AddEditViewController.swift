//
//  AddEditViewController.swift
//  AddressBook
//
//  Created by Paul Deitel on 11/18/14.
//  Copyright (c) 2014 Deitel & Associates, Inc. All rights reserved.
//
import CoreData
import UIKit

class AddEditViewController: UIViewController {
    var contactToEdit: NSManagedObject?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let contact = contactToEdit {
            // optional binding used for all other contact fields
            // because these are optional in the database
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
