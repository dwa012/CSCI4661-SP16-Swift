// DoodleView.swift
// UIView subclass for drawing Squiggles and handling touch events
import UIKit

class DoodleView: UIView {
    var strokeWidth: CGFloat = 10.0
    var drawingColor: UIColor = UIColor.blackColor()
    private var finishedSquiggles: [Squiggle] = []
    private var currentSquiggles: [UITouch : Squiggle] = [:]
    
    // initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.multipleTouchEnabled = true // track multiple fingers
    }
    
    // called by ViewController to remove last Squiggle
    func undo() {
        if finishedSquiggles.count > 0 {
            finishedSquiggles.removeLast()
            self.setNeedsDisplay()
        }
    }
    
    // called by ViewController to remove all Squiggles
    func clear() {
        finishedSquiggles.removeAll()
        self.setNeedsDisplay()
    }
    
    // draws the completed and in-progress Squiggles
    override func drawRect(rect: CGRect) {
        for squiggle in finishedSquiggles {
            squiggle.stroke()
        }
        
        for squiggle in currentSquiggles.values {
            squiggle.stroke()
        }
    }
    
    // adds new Squiggles to Dictionary currentSquiggles
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let squiggle =
                Squiggle(color: drawingColor, strokeWidth: strokeWidth)
            squiggle.moveToPoint(touch.locationInView(self))
            currentSquiggles[touch] = squiggle
        }
    }
    
    // updates existing Squiggles in Dictionary currentSquiggles
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            currentSquiggles[touch]?.addLineToPoint(
                touch.locationInView(self))
            setNeedsDisplay()
        }
    }
    
    // adds finalized Squiggles to Array finishedSquiggles
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            if let squiggle = currentSquiggles[touch] {
                finishedSquiggles.append(squiggle)
            }
            currentSquiggles[touch] = nil // delete touch from Dictionary
        }
    }
    
    // if touches interruped by iOS, removes in-progress Squiggles
    override func touchesCancelled(touches: Set<UITouch>?,
        withEvent event: UIEvent?) {
        currentSquiggles.removeAll()
    }
    
    // computed property that returns UIImage of DoodleView's contents
    var image: UIImage {
        // begin an image graphics context the size of the DoodleView
        UIGraphicsBeginImageContextWithOptions(
            self.bounds.size, true, 0.0)
        
        // render DoodleView's contents into the image graphics context
        self.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        
        // get the UIImage from the image graphics context
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext() // end the image graphics context
        return newImage
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

