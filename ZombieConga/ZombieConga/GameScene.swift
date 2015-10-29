//
//  GameScene.swift
//  ZombieConga
//
//  Created by jim Veneskey on 10/29/15.
//  Copyright (c) 2015 Jim Veneskey. All rights reserved.
//

import SpriteKit
class GameScene: SKScene {
    
    override func didMoveToView(view: SKView) {
    backgroundColor = SKColor.blackColor()
    
    let background = SKSpriteNode(imageNamed: "background1")
    let zombie = SKSpriteNode(imageNamed: "zombie1")
    
    // method #1 of setting the postion of the background image
    // background.position = CGPoint(x: size.width/2, y: size.height/2)

    // method #2
    // background.anchorPoint = CGPoint.zero
    // background.position = CGPoint.zero
    
    // method #3
    background.position = CGPoint(x: size.width/2, y: size.height/2)
    background.anchorPoint = CGPoint(x: 0.5, y: 0.5) // default
    
    // Experimenting with rotation
    // background.zRotation = CGFloat(M_PI) / 8
    
    // ensure that the background position is the bottommost layer
    background.zPosition = -1
    
    // position the zombie
    zombie.position = CGPoint(x: 400, y: 400)
    
    // Zoom the zombie by 2x
    zombie.setScale(2.0)
    
    addChild(background)
    addChild(zombie)
    
    // How big is our background sprite?
    let mySize = background.size
    print("Size is \(mySize)")
    
    }
}
