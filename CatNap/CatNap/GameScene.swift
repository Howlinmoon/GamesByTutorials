//
//  GameScene.swift
//  CatNap
//
//  Created by jim Veneskey on 11/12/15.
//  Copyright (c) 2015 Jim Veneskey. All rights reserved.
//

import SpriteKit

protocol CustomNodeEvents {
    func didMoveToScene()
}

struct PhysicsCategory {
    static let None: UInt32 = 0
    static let Cat: UInt32 = 0b1 //1
    static let Block: UInt32 = 0b10 //2
    static let Bed: UInt32 = 0b100 // 4
}

class GameScene: SKScene {
    
    var bedNode: BedNode!
    var catNode: CatNode!
    
    
    override func didMoveToView(view: SKView) {
        // Calculate playable margin
        
        let maxAspectRatio: CGFloat = 16.0/9.0 // iPhone 5
        let maxAspectRatioHeight = size.width / maxAspectRatio
        let playableMargin: CGFloat = (size.height - maxAspectRatioHeight)/2
        
        let playableRect = CGRect(x: 0, y: playableMargin,
            width: size.width, height: size.height-playableMargin*2)
        
        physicsBody = SKPhysicsBody(edgeLoopFromRect: playableRect)
        physicsWorld.contactDelegate = self
        physicsBody!.categoryBitMask = PhysicsCategory.Edge
        
        enumerateChildNodesWithName("//*", usingBlock: {node, _ in
            if let customNode = node as? CustomNodeEvents {
                customNode.didMoveToScene()
            }
        })
        
        bedNode = childNodeWithName("bed") as! BedNode
        catNode = childNodeWithName("//cat_body") as! CatNode
        
        //    bedNode.setScale(1.5)
        //    catNode.setScale(1.5)
        
        SKTAudio.sharedInstance().playBackgroundMusic("backgroundMusic.mp3")
        
        physicsBody!.categoryBitMask = PhysicsCategory.Bed
        physicsBody!.collisionBitMask = PhysicsCategory.None
        
    }
    
    
}
