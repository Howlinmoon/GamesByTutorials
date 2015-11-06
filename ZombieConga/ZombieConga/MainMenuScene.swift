//
//  MainMenuScene.swift
//  ZombieConga
//
//  Created by jim Veneskey on 11/6/15.
//  Copyright © 2015 Jim Veneskey. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene {
    let background = SKSpriteNode(imageNamed: "MainMenu")

    override func didMoveToView(view: SKView) {
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(background)
    }
    
    
    func sceneTapped() {
        let myScene = GameScene(size:self.size)
        myScene.scaleMode = scaleMode
        let reveal = SKTransition.doorwayWithDuration(1.5)
        self.view?.presentScene(myScene, transition: reveal)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        sceneTapped()
    }
}