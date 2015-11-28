//
//  CatNode.swift
//  CatNap
//
//  Created by jim Veneskey on 11/18/15.
//  Copyright © 2015 Jim Veneskey. All rights reserved.
//

import SpriteKit

class CatNode: SKSpriteNode, CustomNodeEvents {
    
    func didMoveToScene() {
        print("cat added to scene")
        let catBodyTexture = SKTexture(imageNamed: "cat_body_outline")
        parent!.physicsBody = SKPhysicsBody(texture: catBodyTexture, size: catBodyTexture.size())
        parent!.physicsBody!.categoryBitMask = PhysicsCategory.Cat
        parent!.physicsBody!.collisionBitMask = PhysicsCategory.Block | PhysicsCategory.Edge
        parent!.physicsBody!.contactTestBitMask = PhysicsCategory.Bed | PhysicsCategory.Edge
    }
}
