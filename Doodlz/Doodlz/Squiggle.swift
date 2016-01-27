// Squiggle.swift
// UIBezierPath subclass that also stores the drawing color
import UIKit

class Squiggle : UIBezierPath {
    private var color: UIColor
    
    // configure the Squiggle's properties
    init(color: UIColor, strokeWidth: CGFloat) {
        self.color = color
        super.init()
        self.lineWidth = strokeWidth
        self.lineCapStyle = CGLineCap.Round 
        self.lineJoinStyle = CGLineJoin.Round
    }

    // required initializer
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    // set Squiggle's color before drawing it
    override func stroke() {
        color.setStroke() // set the drawing color
        super.stroke() // call superclass method to draw the UIBezierPath
    }
}






/*
// Override to set Squiggle's color before drawing it. We don't use
// this method in this app
override func strokeWithBlendMode(blendMode: CGBlendMode,
    alpha: CGFloat) {
    color.setStroke()
    super.strokeWithBlendMode(blendMode, alpha: alpha)
}
*/


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

