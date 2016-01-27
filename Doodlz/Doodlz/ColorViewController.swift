// ColorViewController.swift
// Manages UI for changing the drawing color
import UIKit

// delegate protocol that class ViewController conforms to
protocol ColorViewControllerDelegate {
    func colorChanged(color:UIColor)
}

class ColorViewController: UIViewController {
    @IBOutlet weak var alphaSlider: UISlider!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var colorView: UIView!
    
    var color: UIColor = UIColor.blackColor()
    var delegate: ColorViewControllerDelegate? = nil
    
    // when view loads, set UISliders to current color component values
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get components of color and set UISlider values
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
        alphaSlider.value = Float(alpha)
        colorView.backgroundColor = color
    }

    // updates colorView's backgroundColor based on UISlider values
    @IBAction func colorChanged(sender: AnyObject) {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: CGFloat(alphaSlider.value))
        color = colorView.backgroundColor!
    }
    
    // returns to ViewController
    @IBAction func done(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) {
            self.delegate?.colorChanged(self.color)
            return
        }
    }
}

// reason for return statement: https://devforums.apple.com/message/1024531#1024531

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

