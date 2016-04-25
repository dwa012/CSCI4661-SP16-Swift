//
//  ContactFormViewController.swift
//  Lab10
//
//  Created by Daniel Ward on 4/13/16.
//  Copyright © 2016 CSCI4669. All rights reserved.
//

import UIKit
import Eureka

class ContactFormViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "saveContact:")
        self.navigationItem.rightBarButtonItem = saveButton
        
        let closeButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "dismiss:")
        self.navigationItem.leftBarButtonItem = closeButton
        
        form +++ Section("Custom cells")
            <<< NameRow("firstName"){
                $0.title = "First Name"
            }
            <<< NameRow("lastName") {
                $0.title = "Last Name"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveContact(sender: AnyObject) {
        let contact = Contact.createNewEntity() as! Contact
        
        for (key, value) in form.values() {
            if let item = value {
                contact.setValue((item as! AnyObject), forKey: key)
            }
        }
        
        do {
            try contact.managedObjectContext?.save()
            self.dismissViewControllerAnimated(true, completion: nil)
        } catch {
            
        }
    }
    
    func dismiss(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}