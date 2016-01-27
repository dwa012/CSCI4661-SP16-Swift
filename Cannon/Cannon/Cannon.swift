// Cannon.swift
// Defines the cannon and handles firing cannonballs
import AVFoundation
import SpriteKit

class Cannon : SKNode {
    // constants
    private let cannonSizePercent = CGFloat(0.15)
    private let cannonballSizePercent = CGFloat(0.075)
    private let cannonBarrelWidthPercent = CGFloat(0.075)
    private let cannonBarrelLengthPercent = CGFloat(0.15)
    private let cannonballSpeed: CGFloat
    private let cannonballSpeedMultiplier = CGFloat(0.25)
    private let barrelLength: CGFloat
    
    private var barrelAngle = CGFloat(0.0)
    private var cannonball: SKSpriteNode!
    var cannonballOnScreen = false

    // initializes the Cannon, sizing it based on the scene's size
    init(sceneSize: CGSize, velocityMultiplier: CGFloat) {
        cannonballSpeed = cannonballSpeedMultiplier * velocityMultiplier
        barrelLength = sceneSize.height * cannonBarrelLengthPercent
        super.init()
        
        // configure cannon barrel
        let barrel = SKShapeNode(rectOfSize: CGSizeMake(barrelLength,
            sceneSize.height * cannonBarrelWidthPercent))
        barrel.fillColor = SKColor.blackColor()
        self.addChild(barrel)

        // configure cannon base
        let cannonBase = SKSpriteNode(imageNamed: "base")
        cannonBase.size = CGSizeMake(sceneSize.height * cannonSizePercent,
            sceneSize.height * cannonSizePercent)
        self.addChild(cannonBase)
        
        // position barrel based on cannonBase
        barrel.position = CGPointMake(cannonBase.size.width / 2.0, 0.0)
    }
    
    // not called, but required if subclass defines an init
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // rotate cannon to user's touch point, then fire cannonball
    func rotateToPointAndFire(point: CGPoint, scene: SKScene) {
        // calculate barrel rotation angle
        let deltaX = point.x
        let deltaY = point.y - self.position.y
        barrelAngle = CGFloat(atan2f(Float(deltaY), Float(deltaX)))
        
        // rotate the cannon barrel to touch point, then fire
        let rotateAction = SKAction.rotateToAngle(
            barrelAngle, duration: 0.25, shortestUnitArc: true)
        
        // perform rotate action, then call fireCannonball
        self.runAction(rotateAction, completion: {
            if !self.cannonballOnScreen {
                self.fireCannonball(scene)
            }
        })
    }
    
    // create cannonball, attach to scene and start it moving
    private func fireCannonball(scene: SKScene) {
        cannonballOnScreen = true

        // determine starting point for cannonball based on
        // barrelLength and current barrelAngle
        let x = cos(barrelAngle) * barrelLength
        let y = sin(barrelAngle) * barrelLength
        let cannonball = createCannonball(scene.frame.size)
        cannonball.position = CGPointMake(x, self.position.y + y)
        
        // create based on barrel angle
        let velocityVector =
            CGVectorMake(x * cannonballSpeed, y * cannonballSpeed)
        
        // put cannonball on screen, move it and play fire sound
        scene.addChild(cannonball)
        cannonball.physicsBody?.applyImpulse(velocityVector)
        cannonFireSound.play()
    }
    
    // creates the cannonball and configures its physicsBody
    func createCannonball(sceneSize: CGSize) -> SKSpriteNode {
        cannonball = SKSpriteNode(imageNamed: "ball")
        cannonball.size =
            CGSizeMake(sceneSize.height * cannonballSizePercent,
                sceneSize.height * cannonballSizePercent)
        
        // set up physicsBody
        cannonball.physicsBody =
            SKPhysicsBody(circleOfRadius: cannonball.size.width / 2.0)
        cannonball.physicsBody?.friction = 0.0
        cannonball.physicsBody?.restitution = 1.0
        cannonball.physicsBody?.linearDamping = 0.0
        cannonball.physicsBody?.allowsRotation = true
        cannonball.physicsBody?.usesPreciseCollisionDetection = true
        cannonball.physicsBody?.categoryBitMask =
            CollisionCategory.Cannonball
        cannonball.physicsBody?.contactTestBitMask =
            CollisionCategory.Target | CollisionCategory.Blocker |
            CollisionCategory.Wall
        return cannonball
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


