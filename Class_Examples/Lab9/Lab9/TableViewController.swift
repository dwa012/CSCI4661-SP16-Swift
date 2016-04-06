//
//  TableViewController.swift
//  Lab9
//
//  Created by Daniel Ward on 4/6/16.
//  Copyright © 2016 CSCI4669. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    lazy var managedObjectContext: NSManagedObjectContext = {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.managedObjectContext
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    // UITableViewDelegate methods
    // callback that returns total number of sections in UITableView
    override func numberOfSectionsInTableView(
        tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }
    
    // callback that returns number of rows in the UITableView
    override func tableView(tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        let sectionInfo =
            self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    // callback that returns a configured cell for the given NSIndexPath
    override func tableView(tableView: UITableView,
                            cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    // callback that returns whether a cell is editable
    override func tableView(tableView: UITableView,
                            canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // callback that deletes a row from the UITableView
    override func tableView(tableView: UITableView,
                            commitEditingStyle editingStyle: UITableViewCellEditingStyle,
                                               forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let context = self.fetchedResultsController.managedObjectContext
            context.deleteObject(
                self.fetchedResultsController.objectAtIndexPath(indexPath) as! Post
            )
            
            var error: NSError? = nil
            do {
                try context.save()
            } catch let error1 as NSError {
                error = error1
                displayError(
                    error,
                    title: "Unable to Load Data",
                    message: "AddressBook unable to acccess database"
                )
            }
        }
    }
    
 
    // MARK: Helpers
    
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let contact = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Post
        cell.textLabel!.text = contact.lastname
        cell.detailTextLabel!.text = contact.firstname
    }
    
    // indicate that an error occurred when saving database changes
    func displayError(error: NSError?, title: String, message: String) {
        // create UIAlertController to display error message
        let alertController = UIAlertController(
            title: title,
            message: String(format: "%@\nError:\(error)\n", message),
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        let okAction = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Cancel, handler: nil
        )
        
        alertController.addAction(okAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func fetchAndInsertItems() {
        // TODO 
    }

 
    // MARK: NSFetchedResultsController
    
    // Core Data autogenerated code for interacting with the data model;
    // sightly modified to work with the Contact entity
    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest = NSFetchRequest()
        
        // edited to use the Contact entity
        let entity = NSEntityDescription.entityForName("Post",
                                                       inManagedObjectContext: self.managedObjectContext)
        fetchRequest.entity = entity
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // edited to sort by last name, then first name;
        // both using case insensitive comparisons
        let userIdSortDescriptor = NSSortDescriptor(key: "userId",
                                                      ascending: true)
        
        fetchRequest.sortDescriptors =
            [userIdSortDescriptor]
        
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: self.managedObjectContext,
            sectionNameKeyPath: nil, cacheName: "Master"
        )
        
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        var error: NSError? = nil
        do {
            try _fetchedResultsController!.performFetch()
        } catch let error1 as NSError {
            error = error1
            displayError(
                error,
                title: "Error Fetching Data",
                message: "Unable to get data from database"
            )
        }
        
        return _fetchedResultsController!
    }
    var _fetchedResultsController: NSFetchedResultsController? = nil
    
    func controllerWillChangeContent(
        controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController,didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        
        switch type {
        case .Insert:
            self.tableView.insertSections(NSIndexSet(index: sectionIndex),
                                          withRowAnimation: .Fade)
        case .Delete:
            self.tableView.deleteSections(NSIndexSet(index: sectionIndex),
                                          withRowAnimation: .Fade)
        default:
            return
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths(
                [newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths(
                [indexPath!], withRowAnimation: .Fade)
        case .Update:
            self.configureCell(
                tableView.cellForRowAtIndexPath(indexPath!)!,
                atIndexPath: indexPath!)
        case .Move:
            tableView.deleteRowsAtIndexPaths(
                [indexPath!], withRowAnimation: .Fade)
            tableView.insertRowsAtIndexPaths(
                [newIndexPath!], withRowAnimation: .Fade)
        }
        
    }
    
    func controllerDidChangeContent(
        controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
}
