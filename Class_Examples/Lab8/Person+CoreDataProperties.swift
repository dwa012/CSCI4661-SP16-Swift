//
//  Person+CoreDataProperties.swift
//  Lab8
//
//  Created by Daniel Ward on 3/30/16.
//  Copyright © 2016 Daniel Ward. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Person {

    @NSManaged var first_name: String?
    @NSManaged var last_name: String?

}
