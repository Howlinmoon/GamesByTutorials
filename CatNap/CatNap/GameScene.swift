//
//  GameScene.swift
//  CatNap
//
//  Created by jim Veneskey on 11/12/15.
//  Copyright (c) 2015 Jim Veneskey. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        // Calculate Playable Margin
        
        let maxAspectRatio: CGFloat = 16.0 / 9.0 // iPhone 5
        let maxAspectRatioHeight = size.width / maxAspectRatio
        let playableMargin: CGFloat = (size.height - maxAspectRatioHeight)/2
        
        let playableRect = CGRect(x:0, y: playableMargin, width: size.width, height: size.height-playableMargin*2)
        
        physicsBody = SKPhysicsBody(edgeLoopFromRect: playableRect)
    }
}
