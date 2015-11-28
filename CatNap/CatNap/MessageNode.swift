//
//  MessageNode.swift
//  CatNap
//
//  Created by Jim Veneskey on 11/28/15.
//  Copyright © 2015 Jim Veneskey. All rights reserved.
//

import SpriteKit
class MessageNode: SKLabelNode {
    convenience init(message: String) {
        self.init(fontNamed: "AvenirNext-Regular")
        text = message
        fontSize = 256.0
        fontColor = SKColor.grayColor()
        zPosition = 100
        
        let front = SKLabelNode(fontNamed: "AvenirNext-Regular")
        front.text = message
        front.fontSize = 256.0
        front.fontColor = SKColor.whiteColor()
        front.position = CGPoint(x: -2, y: -2)
        addChild(front)
        
        // Give the label some physics
        physicsBody = SKPhysicsBody(circleOfRadius: 10)
        physicsBody!.collisionBitMask = PhysicsCategory.Edge
        physicsBody!.categoryBitMask = PhysicsCategory.Label
        physicsBody!.restitution = 0.7
        
    }
}
