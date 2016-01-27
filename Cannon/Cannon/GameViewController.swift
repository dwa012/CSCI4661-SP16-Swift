// GameViewController.swift
// Creates and presents the GameScene
import AVFoundation
import UIKit
import SpriteKit

// sounds defined once and reused throughout app
var blockerHitSound: AVAudioPlayer!
var targetHitSound: AVAudioPlayer!
var cannonFireSound: AVAudioPlayer!

class GameViewController: UIViewController {
    // called when GameViewController is displayed on screen
    override func viewDidLoad() {
        super.viewDidLoad()

        // load sounds when view controller loads
        blockerHitSound = try? AVAudioPlayer(contentsOfURL:
            NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(
                "blocker_hit", ofType: "wav")!))
        targetHitSound = try? AVAudioPlayer(contentsOfURL:
            NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(
                "target_hit", ofType: "wav")!))
        cannonFireSound = try? AVAudioPlayer(contentsOfURL:
            NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(
                "cannon_fire", ofType: "wav")!))
        
        let scene = GameScene(size: view.bounds.size) // create scene
        scene.scaleMode = .AspectFill // resize scene to fit the screen
        
        let skView = view as! SKView // get GameViewController's SKView
        skView.showsFPS = true // display frames-per-second
        skView.showsNodeCount = true // display # of nodes on screen
        skView.ignoresSiblingOrder = true // for SpriteKit optimizations
        skView.presentScene(scene) // display the scene
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

