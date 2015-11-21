//
//  BlockNode.swift
//  CatNap
//
//  Created by Jim Veneskey on 11/21/15.
//  Copyright © 2015 Jim Veneskey. All rights reserved.
//

import SpriteKit
class BlockNode: SKSpriteNode, CustomNodeEvents, InteractiveNode {
    func didMoveToScene() {
        userInteractionEnabled = true
    }
    
    func interact() {
        userInteractionEnabled = false
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        print("destroy block")
        interact()
    }
}
