//
//  GameScene.swift
//  AvailableFonts
//
//  Created by jim Veneskey on 11/9/15.
//  Copyright (c) 2015 Jim Veneskey. All rights reserved.
//

import SpriteKit
class GameScene: SKScene {
    var familyIdx: Int = 0
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        showCurrentFamily()
    }
    
    func showCurrentFamily() {
        // TODO: Coming soon...
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        familyIdx++
        if familyIdx >= UIFont.familyNames().count {
            familyIdx = 0
        }
        showCurrentFamily()
    }
}