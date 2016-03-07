//
//  ViewController.swift
//  Lab 6
//
//  Created by Daniel Ward on 3/2/16.
//  Copyright © 2016 Daniel Ward. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var button: UIButton!
    
    var speed : Int = 1
    var running = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.updateTimingValue()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "defaultsChanged:", name: NSUserDefaultsDidChangeNotification, object: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func startAnimation(sender: AnyObject) {
        if !running {
            button.setTitle("Running", forState: .Normal)
            enqueueColorChange()
        } else {
            button.setTitle("Stopped", forState: .Normal)
        }
        
        running = !running
    }
    
    func defaultsChanged(sender: NSNotification) {
        self.updateTimingValue()
    }
    
    private func updateTimingValue() {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let timingSetting = defaults.valueForKey("timing") as? String, speedInt = Int(timingSetting) {
            speed = speedInt
        }
    }
    
    private func enqueueColorChange() {
        dispatch_after(
            dispatch_time(DISPATCH_TIME_NOW, Int64(speed * Int(NSEC_PER_SEC))), // delay time
            dispatch_get_main_queue(), // which queue
            {
                self.colorView.backgroundColor = UIColor.random()
                if self.running {
                    self.enqueueColorChange()
                }
            } 
        )
    }
}

