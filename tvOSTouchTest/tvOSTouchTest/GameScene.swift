//
//  GameScene.swift
//  tvOSTouchTest
//
//  Created by jim Veneskey on 11/10/15.
//  Copyright (c) 2015 Jim Veneskey. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    //1
    let pressLabel = SKLabelNode(fontNamed: "Chalkduster")
    //2
    let touchBox = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 100, height: 100))
    
    override func didMoveToView(view: SKView) {
        // 3
        pressLabel.text = "Move your finger"
        pressLabel.fontSize = 200
        pressLabel.verticalAlignmentMode = .Center
        pressLabel.horizontalAlignmentMode = .Center
        pressLabel.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(pressLabel)
        
        //4
        addChild(touchBox)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            touchBox.position = location
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            touchBox.position = location
        }
    }

    //1
    override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        for press in presses {
            //2
            switch press.type {
            case .UpArrow:
                pressLabel.text = "Up Arrow"
            case .DownArrow:
                pressLabel.text = "Down Arrow"
            case .RightArrow:
                pressLabel.text = "Right Arrow"
            case .LeftArrow:
                pressLabel.text = "Left Arrow"
            case .Select:
                pressLabel.text = "Select"
            case .Menu:
                pressLabel.text = "Menu"
            case .PlayPause:
                pressLabel.text = "Play/Pause"
            }
        }
    }
    
    override func pressesEnded(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        //3
        self.removeAllActions()
        runAction(SKAction.sequence([
            SKAction.waitForDuration(10),
            SKAction.runBlock() {
                self.pressLabel.text = ""
            }
            ]))
    }


}