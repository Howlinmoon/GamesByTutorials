//
//  GameScene.swift
//  MotionTutorial
//
//  Created by jim Veneskey on 10/9/15.
//  Copyright (c) 2015 Jim Veneskey. All rights reserved.
//

import SpriteKit
import CoreMotion


class GameScene: SKScene {
    
    var airplane = SKSpriteNode()
    var motionManager = CMMotionManager()
    var destX:CGFloat = 0.0
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
    
        // 1
        airplane = SKSpriteNode(imageNamed: "Airplane")
        airplane.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        self.addChild(airplane)
        
        
        if motionManager.accelerometerAvailable == true {
            // 2
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler:{
                data, error in
                
                let currentX = self.airplane.position.x
                
                self.destX = currentX + CGFloat(data!.acceleration.x * 200)
                
            })
            
        } else {
            print("This isn't going to do very much in the simulator, use a real device!\n")
            self.destX = self.airplane.position.x        }
    
    
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        let action = SKAction.moveToX(destX, duration: 1.5)
        self.airplane.runAction(action)
    }
}
