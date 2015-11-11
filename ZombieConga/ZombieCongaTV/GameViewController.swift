//
//  GameViewController.swift
//  ZombieCongaTV
//
//  Created by jim Veneskey on 11/11/15.
//  Copyright (c) 2015 Jim Veneskey. All rights reserved.
//

import UIKit
import SpriteKit
class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = MainMenuScene(size:CGSize(width: 2048, height: 1536))
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .AspectFill
        skView.presentScene(scene)
    }
}