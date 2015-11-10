//
//  GameViewController.swift
//  tvOSTouchTest
//
//  Created by jim Veneskey on 11/10/15.
//  Copyright (c) 2015 Jim Veneskey. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    let gameScene = GameScene(size:CGSize(width: 2048, height: 1536))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        gameScene.scaleMode = .AspectFill
        skView.presentScene(gameScene)
    }
    
    override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        gameScene.pressesBegan(presses, withEvent: event)
    }
    
    override func pressesEnded(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
            gameScene.pressesEnded(presses, withEvent: event)
    }
    
}
