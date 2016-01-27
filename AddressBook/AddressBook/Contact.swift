// Contact.swift
// Xcode generated class for interacting with a Contact; we edited
// this class to make all but the lastName and firstName optionals
import Foundation
import CoreData

class Contact: NSManagedObject {
    @NSManaged var city: String?
    @NSManaged var email: String?
    @NSManaged var firstname: String
    @NSManaged var lastname: String
    @NSManaged var phone: String?
    @NSManaged var state: String?
    @NSManaged var street: String?
    @NSManaged var zip: String?
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