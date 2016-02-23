//
//  OtherViewController.swift
//  lab3
//
//  Created by Daniel Ward on 2/10/16.
//  Copyright © 2016 Daniel Ward. All rights reserved.
//

import UIKit

class OtherViewController: UIViewController {

    @IBOutlet weak var detailView: UIView!
    
    var color: UIColor? {
        didSet {
            if let theColor = color, theDetailView = detailView {
                theDetailView.backgroundColor = theColor
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let theColor = color {
            color = theColor
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func buttonAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
