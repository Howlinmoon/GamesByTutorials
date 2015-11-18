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
    }
}
