// GameOverScene.swift
// Displays a game over scene with elapsed time
import SpriteKit

class GameOverScene: SKScene {
    // configure GameOverScene
    init(size: CGSize, won: Bool, time: CFTimeInterval) {
        super.init(size: size)
        self.backgroundColor = SKColor.whiteColor()
        let greenColor =
            SKColor(red: 0.0, green: 0.6, blue: 0.0, alpha: 1.0)
        
        let gameOverLabel = SKLabelNode(fontNamed: "Chalkduster")
        gameOverLabel.text = (won ? "You Win!" : "You Lose")
        gameOverLabel.fontSize = 60
        gameOverLabel.fontColor =
            (won ? greenColor : SKColor.redColor())
        gameOverLabel.position.x = size.width / 2.0
        gameOverLabel.position.y =
            size.height / 2.0 + gameOverLabel.fontSize
        self.addChild(gameOverLabel)
        
        let elapsedTimeLabel = SKLabelNode(fontNamed: "Chalkduster")
        elapsedTimeLabel.text =
            String(format: "Elapsed Time: %.1f seconds", time)
        elapsedTimeLabel.fontSize = 24
        elapsedTimeLabel.fontColor = SKColor.blackColor()
        elapsedTimeLabel.position.x = size.width / 2.0
        elapsedTimeLabel.position.y = size.height / 2.0
        self.addChild(elapsedTimeLabel)

        let newGameLabel = SKLabelNode(fontNamed: "Chalkduster")
        newGameLabel.text = "Begin New Game"
        newGameLabel.fontSize = 24
        newGameLabel.fontColor = greenColor
        newGameLabel.position.x = size.width / 2.0
        newGameLabel.position.y =
            size.height / 2.0 - gameOverLabel.fontSize
        self.addChild(newGameLabel)
    }

    // not called, but required if you override SKScene's init
    required init?(coder aDecoder: NSCoder) {	
        fatalError("init(coder:) has not been implemented")
    }
    
    // present a new GameScene when user touches screen
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let doorTransition =
            SKTransition.doorsOpenHorizontalWithDuration(1.0)
        let scene = GameScene(size: self.size)
        scene.scaleMode = .AspectFill
        self.view?.presentScene(scene, transition: doorTransition)
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

