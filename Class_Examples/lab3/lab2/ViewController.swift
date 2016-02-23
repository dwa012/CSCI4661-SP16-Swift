//
//  ViewController.swift
//  lab2
//
//  Created by Daniel Ward on 2/3/16.
//  Copyright © 2016 Daniel Ward. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var buttonFlag: Bool = false
    
    
    @IBOutlet weak var colorView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonAction(sender: AnyObject) {
        if buttonFlag {
            colorView.backgroundColor = UIColor.redColor()
        } else {
            colorView.backgroundColor = UIColor.purpleColor()
        }
        
        buttonFlag = !buttonFlag
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let controller = segue.destinationViewController as? OtherViewController {
            controller.color = colorView.backgroundColor
        }
    }
}

