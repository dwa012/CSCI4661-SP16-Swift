// ViewController.swift
// Implements the tip calculator's logic

import UIKit

class ViewController: UIViewController {
    // properties for programmatically interacting with GUI components
    @IBOutlet weak var billAmountLabel: UILabel!
    @IBOutlet weak var customTipPercentLabel1: UILabel!
    @IBOutlet weak var customTipPercentageSlider: UISlider!
    @IBOutlet weak var customTipPercentLabel2: UILabel!
    @IBOutlet weak var tip15Label: UILabel!
    @IBOutlet weak var total15Label: UILabel!
    @IBOutlet weak var tipCustomLabel: UILabel!
    @IBOutlet weak var totalCustomLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!

    // NSDecimalNumber constants used in the calculateTip method
    let decimal100 = NSDecimalNumber(string: "100.0")
    let decimal15Percent = NSDecimalNumber(string: "0.15")

    // called when the view loads
    override func viewDidLoad() {
        super.viewDidLoad()

        // select inputTextField so keypad displays when the view loads
        inputTextField.becomeFirstResponder()
    }

    // called when the user edits the text in the inputTextField
    // or moves the customTipPercentageSlider's thumb
    @IBAction func calculateTip(sender: AnyObject) {
        let inputString = inputTextField.text // get user input

        // convert slider value to an NSDecimalNumber
        let sliderValue =
        NSDecimalNumber(integer: Int(customTipPercentageSlider.value))

        // divide sliderValue by decimal100 (100.0) to get tip %
        let customPercent = sliderValue / decimal100

        // did customTipPercentageSlider generate the event?
        if sender is UISlider {
            // thumb moved so update the Labels with new custom percent
            customTipPercentLabel1.text =
                    NSNumberFormatter.localizedStringFromNumber(customPercent,
                            numberStyle: NSNumberFormatterStyle.PercentStyle)
            customTipPercentLabel2.text = customTipPercentLabel1.text
        }

        // if there is a bill amount, calculate tips and totals
        if let input = inputString {
            if !input.isEmpty {
                // convert to NSDecimalNumber and insert decimal point
                let billAmount =
                NSDecimalNumber(string: input) / decimal100

                // did inputTextField generate the event?
                if sender is UITextField {
                    // update billAmountLabel with currencey formatted total
                    billAmountLabel.text = " " + formatAsCurrency(billAmount)

                    // calculate and display the 15% tip and total
                    let fifteenTip = billAmount * decimal15Percent
                    tip15Label.text = formatAsCurrency(fifteenTip)
                    total15Label.text =
                            formatAsCurrency(billAmount + fifteenTip)
                }

                // calculate custom tip and display custom tip and total
                let customTip = billAmount * customPercent
                tipCustomLabel.text = formatAsCurrency(customTip)
                totalCustomLabel.text =
                        formatAsCurrency(billAmount + customTip)
            }
        } else {
            // clear all Labels
            billAmountLabel.text = ""
            tip15Label.text = ""
            total15Label.text = ""
            tipCustomLabel.text = ""
            totalCustomLabel.text = ""
        }
    }
}

// convert a numeric value to localized currency string
func formatAsCurrency(number: NSNumber) -> String {
    return NSNumberFormatter.localizedStringFromNumber(
    number, numberStyle: NSNumberFormatterStyle.CurrencyStyle)
}

// overloaded + operator to add NSDecimalNumbers
func +(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByAdding(right)
}

// overloaded * operator to multiply NSDecimalNumbers
func *(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByMultiplyingBy(right)
}

// overloaded / operator to divide NSDecimalNumbers
func /(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByDividingBy(right)
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
* www.deitel.com/books/ios8fp/. If you have any questions, please email  *
* us at deitel@deitel.com.                                               *
*************************************************************************/
