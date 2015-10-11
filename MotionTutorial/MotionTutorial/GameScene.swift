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
    var destY:CGFloat = 0.0
    var maxX:CGFloat = 0.0
    var maxY:CGFloat = 0.0
    
    func resetCoOrds () {
        self.maxX = frame.size.width
        self.maxY = frame.size.height
        self.destX = maxX / 2
        self.destY = maxY / 2
        
        let action = SKAction.moveTo(CGPointMake(self.destX,self.destY),duration: 0)
        self.airplane.runAction(action)
        print("Reset to \(self.maxX), \(self.maxY)")
    }
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
    
        // 1
        self.maxX = frame.size.width
        self.maxY = frame.size.height
        print("Maxium X: \(self.maxX), Maximum Y: \(self.maxY)\n")
        airplane = SKSpriteNode(imageNamed: "Airplane")
        airplane.position = CGPointMake(self.maxX/2, self.maxY/2)
        self.addChild(airplane)
        
        let airplaneWidth = airplane.size.width
        let airplaneHeight = airplane.size.height
        print("The width of the airplane is: \(airplaneWidth)")
        print("The height of the airplane is: \(airplaneHeight)")
        
        if motionManager.accelerometerAvailable == true {
            // 2
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler:{
                data, error in
                
                let currentX = self.airplane.position.x
                let currentY = self.airplane.position.y
                
                self.destX = currentX + CGFloat(data!.acceleration.x * 200)
                self.destY = currentY + CGFloat(data!.acceleration.y * 200)
                
                // some simple boundary checking
                if self.destX < airplaneWidth * 2 {
                    self.destX = airplaneWidth * 2
                }
                
                if self.destX > self.maxX - (airplaneWidth * 2) {
                    self.destX = self.maxX - (airplaneWidth * 2)
                }

                if self.destY < airplaneHeight {
                    self.destY = airplaneHeight
                }
                
                if self.destY > self.maxY - airplaneHeight {
                    self.destY = self.maxY - airplaneHeight
                }
                
                //print("destX: \(self.destX), destY: \(self.destY)\n")
                
                
                
                
            })
            
        } else {
            print("This isn't going to do very much in the simulator, use a real device!\n")
            self.destX = self.airplane.position.x
            self.destY = self.airplane.position.y
        }
    
    
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        
        let action = SKAction.moveTo(CGPointMake(self.destX,self.destY), duration: 1.5)
        self.airplane.runAction(action)
    }
}
