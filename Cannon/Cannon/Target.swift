// Target.swift
// Defines a target
import AVFoundation
import SpriteKit

// enum of target sizes
enum TargetSize: CGFloat {
    case Small = 1.0
    case Medium = 1.5
    case Large = 2.0
}

// enum of target sprite names
enum TargetColor: String {
    case Red = "target_red"
    case Green = "target_green"
    case Blue = "target_blue"
}

// arrays of enum constants used for random selections;
// global because Swift does not yet support class variables
private let targetColors =
    [TargetColor.Red, TargetColor.Green, TargetColor.Blue]
private let targetSizes =
    [TargetSize.Small, TargetSize.Medium, TargetSize.Large]

class Target : SKSpriteNode {
    // constants for configuring a blocker
    private let targetWidthPercent = CGFloat(0.025)
    private let targetHeightPercent = CGFloat(0.1)
    private let targetSpeed = CGFloat(2.0)
    private let targetSize: TargetSize
    private let targetColor: TargetColor
    
    // initializes the Cannon, sizing it based on the scene's size
    init(sceneSize: CGSize) {
        // select random target size and random color
        self.targetSize = targetSizes[
            Int(arc4random_uniform(UInt32(targetSizes.count)))]
        self.targetColor = targetColors[
            Int(arc4random_uniform(UInt32(targetColors.count)))]
        
        // call SKSpriteNode designated initializer
        super.init(
            texture: SKTexture(imageNamed: targetColor.rawValue),
            color: nil,
            size: CGSizeMake(sceneSize.width * targetWidthPercent,
                sceneSize.height * targetHeightPercent *
                    targetSize.rawValue))
        
        // set up the target's physicsBody
        self.physicsBody =
            SKPhysicsBody(texture: self.texture, size: self.size)
        self.physicsBody?.friction = 0.0
        self.physicsBody?.restitution = 1.0
        self.physicsBody?.linearDamping = 0.0
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = CollisionCategory.Target
        self.physicsBody?.contactTestBitMask =
            CollisionCategory.Cannonball
    }
    
    // not called, but required if subclass defines an init
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // applies an impulse to the target
    func startMoving(velocityMultiplier: CGFloat) {
        self.physicsBody?.applyImpulse(CGVectorMake(0.0,
            velocityMultiplier * targetSize.rawValue * (targetSpeed +
                CGFloat(arc4random_uniform(UInt32(targetSpeed) + 5)))))
    }
    
    // plays the targetHitSound
    func playHitSound() {
        targetHitSound.play()
    }
    
    // returns time bonus based on target size
    func targetTimeBonus() -> CFTimeInterval {
        switch targetSize {
            case .Small:
                return 3.0
            case .Medium:
                return 2.0
            case .Large:
                return 1.0
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


