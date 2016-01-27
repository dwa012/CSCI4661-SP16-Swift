// Blocker.swift
// Defines a blocker
import AVFoundation
import SpriteKit

enum BlockerSize: CGFloat {
    case Small = 1.0
    case Medium = 2.0
    case Large = 3.0
}

class Blocker : SKSpriteNode {
    // constants for configuring a blocker
    private let blockerWidthPercent = CGFloat(0.025)
    private let blockerHeightPercent = CGFloat(0.125)
    private let blockerSpeed = CGFloat(5.0)
    private let blockerSize: BlockerSize
        
    // initializes the Cannon, sizing it based on the scene's size
    init(sceneSize: CGSize, blockerSize: BlockerSize) {
        self.blockerSize = blockerSize
        super.init(
            texture: SKTexture(imageNamed: "blocker"),
            color: nil,
            size: CGSizeMake(sceneSize.width * blockerWidthPercent,
                sceneSize.height * blockerHeightPercent *
                    blockerSize.rawValue))
        
        // set up the blocker's physicsBody
        self.physicsBody =
            SKPhysicsBody(texture: self.texture, size: self.size)
        self.physicsBody?.friction = 0.0
        self.physicsBody?.restitution = 1.0
        self.physicsBody?.linearDamping = 0.0
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = CollisionCategory.Blocker
        self.physicsBody?.contactTestBitMask = CollisionCategory.Cannonball
    }

    // not called, but required if subclass defines an init
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // applies an impulse to the blocker
    func startMoving(velocityMultiplier: CGFloat) {
        self.physicsBody?.applyImpulse(CGVectorMake(0.0,
            velocityMultiplier * blockerSpeed * blockerSize.rawValue))
    }

    // plays the blockerHitSound
    func playHitSound() {
        blockerHitSound.play()
    }
    
    // returns time penalty based on blocker size
    func blockerTimePenalty() -> CFTimeInterval {
        return CFTimeInterval(BlockerSize.Small.rawValue)
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

