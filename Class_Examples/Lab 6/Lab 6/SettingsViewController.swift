//
//  SettingsViewController.swift
//  Lab 6
//
//  Created by Daniel Ward on 3/2/16.
//  Copyright © 2016 Daniel Ward. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var speedTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let timingSetting = defaults.valueForKey("timing") as? String {
            speedTextField.text = timingSetting
        } else {
            speedTextField.text = "1"
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let speedValue = speedTextField.text {
            if !speedValue.isEmpty {
                defaults.setValue(speedValue, forKey: "timing")
            }
        }
        
        defaults.synchronize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
