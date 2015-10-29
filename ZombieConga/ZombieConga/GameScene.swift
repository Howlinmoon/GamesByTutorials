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
    // method #1 of setting the postion of the background image
    // background.position = CGPoint(x: size.width/2, y: size.height/2)

    // method #2
    background.anchorPoint = CGPoint.zero
    background.position = CGPoint.zero
    
    // Experimenting with rotation
    background.zRotation = CGFloat(M_PI) / 8
    
    addChild(background)
    
    }
}
