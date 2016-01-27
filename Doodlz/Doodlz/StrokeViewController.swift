// StrokeViewController.swift
// Manages the UI for changing the stroke width
import UIKit

// UIView subclass for drawing the sample line
class SampleLineView : UIView {
    var sampleLine = UIBezierPath()
    
    // configures UIBezierPath for sample line
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let y = frame.height / 2
        sampleLine.moveToPoint(CGPointMake(10, y))
        sampleLine.addLineToPoint(CGPointMake(frame.width - 10, y))
    }
    
    // draws the UIBezierPath representing the sample line
    override func drawRect(rect: CGRect) {
        UIColor.blackColor().setStroke()
        sampleLine.stroke()
    }
}

// delegate protocol that class ViewController conforms to
protocol StrokeViewControllerDelegate {
    func strokeWidthChanged(width: CGFloat)
}

class StrokeViewController: UIViewController {
    @IBOutlet weak var strokeWidthSlider: UISlider!
    @IBOutlet weak var strokeWidthView: SampleLineView!
    var delegate: StrokeViewControllerDelegate? = nil
    var strokeWidth: CGFloat = 10.0
    
    // configure strokeWidthSlider and redraw strokeWidthView
    override func viewDidLoad() {
        super.viewDidLoad()
        strokeWidthSlider.value = Float(strokeWidth)
        strokeWidthView.sampleLine.lineWidth = strokeWidth
        strokeWidthView.setNeedsDisplay()
    }
    
    // updates strokeWidth and redraws strokeWidthView
    @IBAction func lineWidthChanged(sender: UISlider) {
        strokeWidth = CGFloat(sender.value)
        strokeWidthView.sampleLine.lineWidth = strokeWidth
        strokeWidthView.setNeedsDisplay()
    }
    
    // returns to ViewController
    @IBAction func done(sender: AnyObject) {
        dismissViewControllerAnimated(true){
            self.delegate?.strokeWidthChanged(self.strokeWidth)
            return
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

