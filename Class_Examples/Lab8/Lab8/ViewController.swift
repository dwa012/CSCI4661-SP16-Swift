//
//  ViewController.swift
//  Lab8
//
//  Created by Daniel Ward on 3/30/16.
//  Copyright © 2016 Daniel Ward. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class ViewController: UIViewController {
    let entityName = "Person"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext

        let people = getPeople(context)
        
        if (people.count == 0) {
            let personEntity = NSEntityDescription.entityForName(entityName, inManagedObjectContext: context)
                
            let person = Person(entity: personEntity!, insertIntoManagedObjectContext: context)
            
            person.first_name  = "Bob"
            person.first_name  = "Smith"
            
            appDelegate.saveContext()
        } else {
            print(people.first?.first_name)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getPeople(context: NSManagedObjectContext) -> [Person] {
        let fetchRequest = NSFetchRequest(entityName: entityName)
        
        let sort = NSSortDescriptor(key:"first_name", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        if let results = try? context.executeFetchRequest(fetchRequest) as! [Person] {
            return results
        } else {
            print("There was an error getting the results")
        }
        
        return []
    }
}

