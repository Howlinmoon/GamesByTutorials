//
//  BedNode.swift
//  CatNap
//
//  Created by jim Veneskey on 11/18/15.
//  Copyright © 2015 Jim Veneskey. All rights reserved.
//

import SpriteKit

class BedNode: SKSpriteNode, CustomNodeEvents {
    
    func didMoveToScene() {
        print("bed added to scene")
        let bedBodySize = CGSize(width: 40.0, height: 30.0)
        physicsBody = SKPhysicsBody(rectangleOfSize: bedBodySize)
        // indicate that the cat bed will never move
        physicsBody!.dynamic = false
    }
    
}
