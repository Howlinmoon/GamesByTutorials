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
    let zombieAnimation: SKAction
    
    // used for shared instances of sound effects
    let catCollisionSound: SKAction = SKAction.playSoundFileNamed("hitCat.wav", waitForCompletion: false)
    let enemyCollisionSound: SKAction = SKAction.playSoundFileNamed("hitCatLady.wav", waitForCompletion: false)
    
    // Used for computing update time intervals
    var lastUpdateTime: NSTimeInterval = 0
    var dt: NSTimeInterval = 0
    let zombieMovePointsPerSec: CGFloat = 480.0
    var velocity = CGPoint.zero
    
    // Fix the issue of the zombie moving offscreen on non-ipad devices
    // this requires an initializer
    let playableRect: CGRect
    
    var lastTouchLocation: CGPoint?
    // used for smooth rotation when doing directional changes
    let zombieRotateRadiansPerSec:CGFloat = 4.0 * π
    
    // For the Zombie Cat Conga Line
    var invincible = false
    let catMovePointsPerSec:CGFloat = 480.0
    
    // Gameplay purposes
    var lives = 5
    var gameOver = false
    
    // Experimenting with game camera movements
    let cameraNode = SKCameraNode()

    override func didMoveToView(view: SKView) {
        playBackgroundMusic("backgroundMusic.mp3")
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
        // layer 100
        zombie.zPosition = 100
    
        // Zoom the zombie by 2x
        // zombie.setScale(2.0)
    
        addChild(background)
        addChild(zombie)
        
        // Spawn the Crazy Cat Lady
        runAction(SKAction.repeatActionForever(
            SKAction.sequence([SKAction.runBlock(spawnEnemy),
                SKAction.waitForDuration(2.0)])))
        
        // Spawn the cats!
        runAction(SKAction.repeatActionForever(
        SKAction.sequence([SKAction.runBlock(spawnCat),
        SKAction.waitForDuration(1.0)])))
    
        // How big is our background sprite?
        let mySize = background.size
        print("Size is \(mySize)")
    
        //debugDrawPlayableArea()
        
        // Camera experimenting
        addChild(cameraNode)
        camera = cameraNode
        //cameraNode.position = CGPoint(x: size.width/2, y: size.height/2)
        //cameraNode.position = zombie.position
        setCameraPosition(CGPoint(x: size.width/2, y: size.height/2))
    }
    
    // Original Enemy spawner for historical purposes
    func spawnEnemy_OLD() {
        let enemy = SKSpriteNode(imageNamed: "enemy")
        // enemy initial starting position is half a width off the screen
        enemy.position = CGPoint(x: size.width + enemy.size.width/2, y: size.height/2)
        
        // add it to the scene
        addChild(enemy)
        
        // Setup the actions that move the enemy
        /* old - non-reversable
        let actionMidMove = SKAction.moveTo(CGPoint(x: size.width/2, y: CGRectGetMinY(playableRect) + enemy.size.height/2), duration: 1.0)
        let actionMove = SKAction.moveTo( CGPoint(x: -enemy.size.width/2, y: enemy.position.y), duration: 1.0)
        */
        
        // New - reversable actions
        let actionMidMove = SKAction.moveByX(-size.width/2 - enemy.size.width/2, y: -CGRectGetHeight(playableRect)/2 + enemy.size.height/2, duration: 1.0 )
        
        let actionMove = SKAction.moveByX(-size.width/2 - enemy.size.width/2, y: CGRectGetHeight(playableRect)/2 - enemy.size.height/2, duration: 1.0)
        
        // Add a small pause
        let wait = SKAction.waitForDuration(0.5)
        
        // Add a Log Message
        let logMessage = SKAction.runBlock() {
            print("Reached the bottom!")
        }
        
        // build the sequence made of the above actions
        
        /* reversing the hard way
        let reverseMid = actionMidMove.reversedAction()
        let reverseMove = actionMove.reversedAction()
        let sequence = SKAction.sequence([
            actionMidMove, logMessage, wait, actionMove,
            reverseMove, logMessage, wait, reverseMid
            ])
        */
        
        // reversing the easy way
        let halfSequence = SKAction.sequence(
                [actionMidMove, logMessage, wait, actionMove]
        )
        // Build our sequence from the forward and reversed version of the above
        let sequence = SKAction.sequence(
                [halfSequence, halfSequence.reversedAction()]
        )
        // Run it
        print("Above Run Action")
        //endlessly repeat
        let repeatAction = SKAction.repeatActionForever(sequence)
        enemy.runAction(repeatAction)
        print("Below Run Action")
    }
    
    // Spawn the Crazy Cat Lady
    func spawnEnemy() {
        let enemy = SKSpriteNode(imageNamed: "enemy")
        enemy.name = "enemy"
        enemy.position = CGPoint(
            x: size.width + enemy.size.width/2,
            y: CGFloat.random(
            min: CGRectGetMinY(playableRect) + enemy.size.height/2,
            max: CGRectGetMaxY(playableRect) - enemy.size.height/2))
        addChild(enemy)
        // spawn the enemy - but remove old ones also
        let actionMove = SKAction.moveToX(-enemy.size.width/2, duration: 2.0)
        let actionRemove = SKAction.removeFromParent()
        enemy.runAction(SKAction.sequence([actionMove, actionRemove]))
    }
    
    // Spawn the cats - gradually
    func spawnCat() {
        // 1
        let cat = SKSpriteNode(imageNamed: "cat")
        //let cat = SKSpriteNode(imageNamed: "44")
        cat.name = "cat"
        // randomize the starting location to anywhere in the playable area
        cat.position = CGPoint(
            x: CGFloat.random(min: CGRectGetMinX(playableRect),
                max: CGRectGetMaxX(playableRect)),
            y: CGFloat.random(min: CGRectGetMinY(playableRect),
                max: CGRectGetMaxY(playableRect)))
        
        // hide the cat initially
        cat.setScale(0)
        addChild(cat)
        
        // 2
        // Create our actions
        let appear = SKAction.scaleTo(1.0, duration: 0.5)
        
        // Create a delay action - wiggling
        cat.zRotation = -π / 16.0
        let leftWiggle = SKAction.rotateByAngle(π/8.0, duration: 0.5)
        let rightWiggle = leftWiggle.reversedAction()
        let fullWiggle = SKAction.sequence([leftWiggle, rightWiggle])
        //let wiggleWait = SKAction.repeatAction(fullWiggle, count: 10)
        
        // adding another type of delay action - scaling while wiggling
        let scaleUp = SKAction.scaleBy(1.2, duration: 0.25)
        let scaleDown = scaleUp.reversedAction()
        let fullScale = SKAction.sequence(
            [scaleUp, scaleDown, scaleUp, scaleDown])
        let group = SKAction.group([fullScale, fullWiggle])
        let groupWait = SKAction.repeatAction(group, count: 10)
        
        let disappear = SKAction.scaleTo(0, duration: 0.5)
        let removeFromParent = SKAction.removeFromParent()
        // create the sequence that holds them
        // let actions = [appear, wiggleWait, disappear, removeFromParent]
        let actions = [appear, groupWait, disappear, removeFromParent]
        cat.runAction(SKAction.sequence(actions))
    }
    
    // The master game UPDATE loop
    override func update(currentTime: NSTimeInterval) {
        
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        } else {
            dt = 0
        }
        lastUpdateTime = currentTime
        //print("\(dt*1000) milliseconds since last update")
        
        if let lastTouchLocation = lastTouchLocation {
            let diff = lastTouchLocation - zombie.position
            if (diff.length() <= zombieMovePointsPerSec * CGFloat(dt)) {
                zombie.position = lastTouchLocation
                velocity = CGPointZero
                stopZombieAnimation()
            } else {
                moveSprite(zombie, velocity: velocity)
                rotateSprite(zombie, direction: velocity, rotateRadiansPerSec: zombieRotateRadiansPerSec)
            }
        }
        
        boundsCheckZombie()
        // wrong place for this
        //checkCollisions()
        moveTrain()
        
        // check for game over
        if lives <= 0 && !gameOver {
            gameOver = true
            print("You Lose!")
            backgroundMusicPlayer.stop()
            // 1
            let gameOverScene = GameOverScene(size: size, won: false)
            gameOverScene.scaleMode = scaleMode
            // 2
            let reveal = SKTransition.flipHorizontalWithDuration(0.5)
            // 3
            view?.presentScene(gameOverScene, transition: reveal)
        }
    }
    
    // Proper place in the game cycle sequence for collision checking
    override func didEvaluateActions() {
            checkCollisions()
    }
    
    func moveSprite(sprite: SKSpriteNode, velocity: CGPoint) {
        // 1
        // old style - before leveraging new routines in MyUtils.swift
        //let amountToMove = CGPoint(x: velocity.x * CGFloat(dt), y: velocity.y * CGFloat(dt))
        // new style
        let amountToMove = velocity * CGFloat(dt)
        
        
       // print("Amount to move: \(amountToMove)")
        
        //2
        // old style before leveraging new routines in MyUtils.swift
        //sprite.position = CGPoint(x: sprite.position.x + amountToMove.x, y: sprite.position.y + amountToMove.y)
        // new style
        sprite.position += amountToMove
    }
    
    // Move the zombie towards the current touch position
    func moveZombieToward(location: CGPoint) {
        startZombieAnimation()
        let offset = location - zombie.position
        let direction = offset.normalized()
        velocity = direction * zombieMovePointsPerSec
    }
    
    func sceneTouched(touchLocation: CGPoint) {
        // save where we touched on the screen
        lastTouchLocation = touchLocation
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
    
    // Collision detection
    // Zombie and cat collide - zombiefy the cat
    func zombieHitCat(cat: SKSpriteNode) {
        // tag the cat as belonging to the conga line now
        // this will stop us from enumerating them in collision checks
        cat.name = "train"
        // stop the cat from wiggling
        cat.removeAllActions()
        // fix the scale if needed
        cat.setScale(1.0)
        // fix the rotation if needed
        cat.zRotation = 0
        
        // turn the cat green
        let turnGreen = SKAction.colorizeWithColor(SKColor.greenColor(), colorBlendFactor: 1.0, duration: 0.2)
        cat.runAction(turnGreen)
        
        // play the appropriate sound effect
        runAction(catCollisionSound)
        //runAction(SKAction.playSoundFileNamed("hitCat.wav", waitForCompletion: false))
    }
    
    // Zombie and Crazy Cat Lady collide
    func zombieHitEnemy(enemy: SKSpriteNode) {
        enemy.removeFromParent()
        
        // play the appropriate sound effect
        runAction(enemyCollisionSound)
        // sadly - this costs the Zombie a "life"
        lives--
        // and 2 cats
        loseCats()
        //runAction(SKAction.playSoundFileNamed("hitCatLady.wav", waitForCompletion: false))
        invincible = true
        let blinkTimes = 10.0
        let duration = 3.0
        let blinkAction = SKAction.customActionWithDuration(duration) { node, elapsedTime in
            let slice = duration / blinkTimes
            let remainder = Double(elapsedTime) % slice
            node.hidden = remainder > slice / 2
        }
        let setHidden = SKAction.runBlock() {
            self.zombie.hidden = false
            self.invincible = false
        }
        zombie.runAction(SKAction.sequence([blinkAction, setHidden]))

    }
    
    func checkCollisions() {
        // check for any cats hit by the Zombie
        var hitCats: [SKSpriteNode] = []
        enumerateChildNodesWithName("cat") { node, _ in
            let cat = node as! SKSpriteNode
            if CGRectIntersectsRect(cat.frame, self.zombie.frame) {
                hitCats.append(cat)
            }
        }
        
        // process any collisions detected
        for cat in hitCats {
                zombieHitCat(cat)
        }
        
        // check for any crazy cat ladies hit
        var hitEnemies: [SKSpriteNode] = []
        enumerateChildNodesWithName("enemy") { node, _ in
        let enemy = node as! SKSpriteNode
        if CGRectIntersectsRect(CGRectInset(node.frame, 20, 20), self.zombie.frame) {
                hitEnemies.append(enemy)
            }
        }
        
        // Here is why we don't remove the nodes while enumerating them:
        // Note that you don’t remove the nodes from within the enumeration. 
        // It’s unsafe to remove a node while enumerating over a list of them, and doing so can crash your app.
        
        for enemy in hitEnemies {
            zombieHitEnemy(enemy)
        }
    }
    
    
    
    // game size initializer
    override init(size: CGSize) {
        let maxAspectRatio: CGFloat = 16.0 / 9.0 // 1
        let playableHeight = size.width / maxAspectRatio // 2
        let playableMargin = (size.height - playableHeight) / 2.0 //3
        print("playableHeight = \(playableHeight), playableMargin = \(playableMargin)")
        playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: playableHeight) //4
        // 1
        var textures:[SKTexture] = []
        // 2
        for i in 1...4 {
            textures.append(SKTexture(imageNamed: "zombie\(i)"))
        }
        // 3
        textures.append(textures[2])
        textures.append(textures[1])
        // 4
        zombieAnimation = SKAction.animateWithTextures(textures,
        timePerFrame: 0.1)
        
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
    
    // Adjust the facing of the zombie
    func rotateSprite(sprite: SKSpriteNode, direction: CGPoint,
        rotateRadiansPerSec: CGFloat) {
            let shortest = shortestAngleBetween(sprite.zRotation, angle2: velocity.angle)
            let amountToRotate = min(rotateRadiansPerSec * CGFloat(dt), abs(shortest))
            sprite.zRotation += shortest.sign() * amountToRotate
    }
    
    // stop and start the zombie animation frames
    func startZombieAnimation() {
        if zombie.actionForKey("animation") == nil {
            zombie.runAction(SKAction.repeatActionForever(zombieAnimation),withKey: "animation")
        }
    }
    
    func stopZombieAnimation() {
        zombie.removeActionForKey("animation")
    }
    
    // Move the cat train
    func moveTrain() {
        // keep track of how many cats are in the train for the win
        var trainCount = 0
        
        var targetPosition = zombie.position
        // look for the cat's we tagged as part of the train
        enumerateChildNodesWithName("train") { node, stop in
            trainCount++
            if !node.hasActions() {
                
                let actionDuration = 0.3
                let offset = targetPosition - node.position
                let direction = offset.normalized()
                let amountToMovePerSec = direction * self.catMovePointsPerSec
                let amountToMove = amountToMovePerSec * CGFloat(actionDuration)
                let moveAction = SKAction.moveByX(amountToMove.x, y: amountToMove.y, duration: actionDuration)
                node.runAction(moveAction)
            }
            targetPosition = node.position
            
        }
        
        // well - did we win?
        if trainCount >= 15 && !gameOver {
            gameOver = true
            print("You Win!")
            backgroundMusicPlayer.stop()
            // 1
                let gameOverScene = GameOverScene(size: size, won: true)
            gameOverScene.scaleMode = scaleMode
            // 2
            let reveal = SKTransition.flipHorizontalWithDuration(0.5)
            // 3
            view?.presentScene(gameOverScene, transition: reveal)
        }
        
    }
    
    // Remove cats from the Conga Line
    func loseCats() {
        // 1
        var loseCount = 0
        enumerateChildNodesWithName("train") { node, stop in
            // 2
            // "node" is the currently selected cat sprite/node
            var randomSpot = node.position
            randomSpot.x += CGFloat.random(min: -100, max: 100)
            randomSpot.y += CGFloat.random(min: -100, max: 100)
            
            // 3
            node.name = ""
            node.runAction(
            SKAction.sequence([
                SKAction.group([
                    SKAction.rotateByAngle(π*4, duration: 1.0),
                    SKAction.moveTo(randomSpot, duration: 1.0),
                    SKAction.scaleTo(0, duration: 1.0)
                    ]),
                SKAction.removeFromParent()
                ]))
            // 4
            loseCount++
            if loseCount >= 2 {
                // this stops any further enumerations - otherwise, we'd keep
                // removing all of the cats!
                stop.memory = true
            }
        }
    }
    
    
    
    func overlapAmount() -> CGFloat {
        guard let view = self.view else {
            return 0 }
        let scale = view.bounds.size.width / self.size.width
        let scaledHeight = self.size.height * scale
        let scaledOverlap = scaledHeight - view.bounds.size.height
        return scaledOverlap / scale
    }
    func getCameraPosition() -> CGPoint {
        return CGPoint(x: cameraNode.position.x, y: cameraNode.position.y + overlapAmount()/2)
    }
    func setCameraPosition(position: CGPoint) {
        cameraNode.position = CGPoint(x: position.x, y: position.y - overlapAmount()/2)
    }

    
}
