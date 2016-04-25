//
//  Contact+CoreDataProperties.swift
//  Lab11
//
//  Created by Daniel Ward on 4/25/16.
//  Copyright © 2016 CSCI4669. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Contact {

    @NSManaged var firstName: String?
    @NSManaged var lastName: String?

}
