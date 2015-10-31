//
//  GameScene.swift
//  ZombieConga
//
//  Created by jim Veneskey on 10/29/15.
//  Copyright (c) 2015 Jim Veneskey. All rights reserved.
//

import SpriteKit
class GameScene: SKScene {

    let background = SKSpriteNode(imageNamed: "background1")
    let zombie = SKSpriteNode(imageNamed: "zombie1")
    
    // Used for computing update time intervals
    var lastUpdateTime: NSTimeInterval = 0
    var dt: NSTimeInterval = 0
    let zombieMovePointsPerSec: CGFloat = 480.0
    var velocity = CGPoint.zero
    
    // Fix the issue of the zombie moving offscreen on non-ipad devices
    // this requires an initializer
    let playableRect: CGRect
    

    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.blackColor()
    
    
        // method #1 of setting the postion of the background image
        // background.position = CGPoint(x: size.width/2, y: size.height/2)

        // method #2
        // background.anchorPoint = CGPoint.zero
        // background.position = CGPoint.zero
    
        // method #3
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5) // default
    
        // Experimenting with rotation
        // background.zRotation = CGFloat(M_PI) / 8
    
        // ensure that the background position is the bottommost layer
        background.zPosition = -1
    
        // position the zombie
        zombie.position = CGPoint(x: 400, y: 400)
    
        // Zoom the zombie by 2x
        // zombie.setScale(2.0)
    
        addChild(background)
        addChild(zombie)
    
        // How big is our background sprite?
        let mySize = background.size
        print("Size is \(mySize)")
    
        debugDrawPlayableArea()
    }
    
    // Experiment with moving the zombie
    override func update(currentTime: NSTimeInterval) {
        
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        } else {
            dt = 0
        }
        
        lastUpdateTime = currentTime
       // print("\(dt * 1000) milliseconds since last update")
        
        // old hardcoded mover
        // zombie.position = CGPoint(x: zombie.position.x + 8, y: zombie.position.y)
        
        // new time sensitive mover
        // moveSprite(zombie, velocity: CGPoint(x: zombieMovePointsPerSec, y: 0))
        
        // chase the taps
        moveSprite(zombie, velocity: velocity)
        boundsCheckZombie()
    }
    
    func moveSprite(sprite: SKSpriteNode, velocity: CGPoint) {
        // 1
        let amountToMove = CGPoint(x: velocity.x * CGFloat(dt), y: velocity.y * CGFloat(dt))
        
       // print("Amount to move: \(amountToMove)")
        
        //2
        sprite.position = CGPoint(x: sprite.position.x + amountToMove.x, y: sprite.position.y + amountToMove.y)
    }
    
    // Move the zombie towards the current touch position
    func moveZombieToward(location: CGPoint) {
        let offset = CGPoint(x:location.x - zombie.position.x, y:location.y - zombie.position.y)
        let length = sqrt(Double(offset.x * offset.x + offset.y * offset.y))
        let direction = CGPoint(x: offset.x / CGFloat(length), y: offset.y / CGFloat(length))
        velocity = CGPoint(x: direction.x * zombieMovePointsPerSec, y: direction.y * zombieMovePointsPerSec)
    }
    
    func sceneTouched(touchLocation: CGPoint) {
        moveZombieToward(touchLocation)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let touchLocation = touch.locationInNode(self)
        sceneTouched(touchLocation)
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let touchLocation = touch.locationInNode(self)
        sceneTouched(touchLocation)
    }
    
    func boundsCheckZombie() {
        //let bottomLeft = CGPointZero
        //let topRight = CGPoint(x: size.width, y: size.height)
        
        let bottomLeft = CGPoint(x: 0, y: CGRectGetMinY(playableRect))
        let topRight = CGPoint(x: size.width, y: CGRectGetMaxY(playableRect))
        
        if zombie.position.x <= bottomLeft.x {
            zombie.position.x = bottomLeft.x
            velocity.x = -velocity.x
        }
        
        if zombie.position.x >= topRight.x {
            zombie.position.x = topRight.x
            velocity.x = -velocity.x
        }

        if zombie.position.y <= bottomLeft.y {
            zombie.position.y = bottomLeft.y
            velocity.y = -velocity.y
        }
        
        if zombie.position.y >= topRight.y {
            zombie.position.y = topRight.y
            velocity.y = -velocity.y
        }
        
    }
    
    
    // game size initializer
    override init(size: CGSize) {
        let maxAspectRatio: CGFloat = 16.0 / 9.0 // 1
        let playableHeight = size.width / maxAspectRatio // 2
        let playableMargin = (size.height - playableHeight) / 2.0 //3
        print("playableHeight = \(playableHeight), playableMargin = \(playableMargin)")
        playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: playableHeight) //4
        
        super.init(size: size) // 5
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented") // 6
    }
    
    // Show the playable rectangle on the screen
    func debugDrawPlayableArea() {
        let shape = SKShapeNode()
        let path = CGPathCreateMutable()
        
        CGPathAddRect(path, nil, playableRect)
        shape.path = path
        shape.strokeColor = SKColor.redColor()
        shape.lineWidth = 4.0
        addChild(shape)
    }
    
   
    
    
}
