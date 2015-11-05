/*
* Copyright (c) 2013-2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import SpriteKit

class GameScene: SKScene {

  let playableRect: CGRect
  let cat:SKSpriteNode = SKSpriteNode(imageNamed: "cat")
  let dog:SKSpriteNode = SKSpriteNode(imageNamed: "dog")
  let turtle:SKSpriteNode = SKSpriteNode(imageNamed: "turtle")
  let label:SKLabelNode = SKLabelNode(fontNamed: "Verdana")
  
  override init(size: CGSize) {
    let maxAspectRatio:CGFloat = 16.0/9.0 // iPhone 5"
    let maxAspectRatioHeight = size.width / maxAspectRatio
    let playableMargin = (size.height-maxAspectRatioHeight)/2.0
    playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: size.height-playableMargin*2)

    super.init(size: size)
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func didMoveToView(view: SKView)  {
    
    backgroundColor = SKColor.whiteColor()
    
    cat.position = CGPoint(x: size.width * 1/6, y: size.height / 2)
    addChild(cat)
    
    dog.position = CGPoint(x: size.width * 3/6, y: size.height / 2)
    addChild(dog)
    
    turtle.position = CGPoint(x: size.width * 5/6, y: size.height / 2)
    addChild(turtle)
    
    label.text = "Test"
    label.fontSize = 40
    label.fontColor = SKColor.blackColor()
    label.position = CGPoint(x: size.width / 2, y: CGRectGetMinY(playableRect) + CGRectGetHeight(playableRect) * 1/6)
    addChild(label)
    
  }

}

class MoveScene : GameScene {

  override func didMoveToView(view: SKView)  {
    super.didMoveToView(view)
    
    // moveTo(duration:)
    cat.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.moveTo(CGPoint(x: CGRectGetMinX(playableRect), y:CGRectGetMinY(playableRect)), duration:1.0),
        SKAction.moveTo(cat.position, duration:1.0)
      ])
    ))
    
    // moveByX(y:duration:)
    dog.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.moveByX(0, y: CGRectGetHeight(playableRect) * 1/6, duration: 1.0),
        SKAction.moveByX(0, y: -CGRectGetHeight(playableRect) * 1/6, duration: 1.0)
      ])
    ))
    
    // moveToX(duration:) and moveToY(duration:)
    turtle.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.group([
          SKAction.moveToX(CGRectGetMaxX(playableRect), duration: 1.0),
          SKAction.moveToY(CGRectGetMinY(playableRect), duration: 1.0),
        ]),
        SKAction.group([
          SKAction.moveToX(turtle.position.x, duration: 1.0),
          SKAction.moveToY(turtle.position.y, duration: 1.0),
        ])
      ])
    ))
    
    label.text = "Move Actions / Cross Fade"
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let transition = SKTransition.crossFadeWithDuration(1.0)
    let nextScene = RotateScene(size: size)
    nextScene.scaleMode = scaleMode
    view?.presentScene(nextScene, transition: transition)
  }
  
}

class RotateScene : GameScene {

  override func didMoveToView(view: SKView)  {
    super.didMoveToView(view)
    
    // rotateByAngle(duration:)
    cat.runAction(SKAction.repeatActionForever(
      SKAction.rotateByAngle(π*2, duration: 1.0)
    ))
    
    // rotateToAngle(duration:)
    dog.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.rotateToAngle(π/2, duration: 1.0),
        SKAction.rotateToAngle(π, duration: 1.0),
        SKAction.rotateToAngle(-π/2, duration: 1.0),
        SKAction.rotateToAngle(π, duration: 1.0),
      ])
    ))
    
    // rotateToAngle(duration:shortestUnitArc:)
    turtle.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.rotateToAngle(π/2, duration: 1.0, shortestUnitArc:true),
        SKAction.rotateToAngle(π, duration: 1.0, shortestUnitArc:true),
        SKAction.rotateToAngle(-π/2, duration: 1.0, shortestUnitArc:true),
        SKAction.rotateToAngle(π, duration: 1.0, shortestUnitArc:true),
      ])
    ))
    
    label.text = "Rotate Actions / Fade"
  }

  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let transition = SKTransition.fadeWithDuration(1.0)
    let nextScene = ResizeScene(size: size)
    nextScene.scaleMode = scaleMode
    view?.presentScene(nextScene, transition: transition)
  }

}

class ResizeScene : GameScene {

  override func didMoveToView(view: SKView)  {
    super.didMoveToView(view)
    
    // resizeByWidth(height:duration:)
    cat.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.resizeByWidth(cat.size.width, height: -cat.size.height/2, duration: 1.0),
        SKAction.resizeByWidth(-cat.size.width, height: cat.size.height/2, duration: 1.0)
      ])
    ))
    
    // resizeToWidth(height:duration:)
    dog.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.resizeToWidth(10, height: 200, duration: 1.0),
        SKAction.resizeToWidth(dog.size.width, height: dog.size.height, duration: 1.0)
      ])
    ))
    
    // resizeToWidth(duration:) and resizeToHeight(duration:)
    turtle.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.group([
          SKAction.resizeToWidth(turtle.size.width*2, duration: 1.0),
          SKAction.resizeToHeight(turtle.size.height/2, duration: 1.0)
        ]),
        SKAction.group([
          SKAction.resizeToWidth(turtle.size.width, duration: 1.0),
          SKAction.resizeToHeight(turtle.size.height, duration: 1.0)
        ])
      ])
    ))
    
    label.text = "Resize Actions / Fade with Color"
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let transition = SKTransition.fadeWithColor(SKColor.redColor(), duration:1.0)
    let nextScene = ScaleScene(size: size)
    nextScene.scaleMode = scaleMode
    view?.presentScene(nextScene, transition: transition)
  }
  
}

class ScaleScene : GameScene {

  override func didMoveToView(view: SKView)  {
    super.didMoveToView(view)
    
    // scaleBy(duration:) and scaleTo(duration:)
    cat.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.scaleBy(2.0, duration: 0.5),
        SKAction.scaleBy(2.0, duration: 0.5), // now effectively at 4x
        SKAction.scaleTo(1.0, duration: 1.0),
      ])
    ))
    
    // scaleXBy(y:duration:) and scaleXTo(y:duration:)
    dog.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.scaleXBy(0.25, y:1.25, duration:0.5),
        SKAction.scaleXBy(0.25, y:1.25, duration:0.5), // now effectively xScale 0.0625, yScale 1.565
        SKAction.scaleXTo(1.0, y:1.0, duration:1.0),
      ])
    ))
    
    // resizeToWidth(duration:) and resizeToHeight(duration:)
    turtle.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.group([
          SKAction.scaleXTo(3.0, duration:1.0),
          SKAction.scaleYTo(0.5, duration:1.0)
        ]),
        SKAction.group([
          SKAction.scaleXTo(1.0, duration:1.0),
          SKAction.scaleYTo(1.0, duration:1.0)
        ])
      ])
    ))
    
    label.text = "Scale Actions / Flip Horizontal"
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let transition = SKTransition.flipHorizontalWithDuration(1.0)
    let nextScene = RepeatScene(size: size)
    nextScene.scaleMode = scaleMode
    view?.presentScene(nextScene, transition: transition)
  }
}

class RepeatScene : GameScene {

  override func didMoveToView(view: SKView)  {
    super.didMoveToView(view)
    
    // repeatAction(count:)
    cat.runAction(SKAction.repeatAction(
      SKAction.sequence([
        SKAction.moveByX(0, y: CGRectGetHeight(playableRect) * 1/6, duration: 0.2),
        SKAction.moveByX(0, y: -CGRectGetHeight(playableRect) * 1/6, duration: 0.2)
      ]), count:2
    ))
    
    dog.runAction(SKAction.repeatAction(
      SKAction.sequence([
        SKAction.moveByX(0, y: CGRectGetHeight(playableRect) * 1/6, duration: 0.2),
        SKAction.moveByX(0, y: -CGRectGetHeight(playableRect) * 1/6, duration: 0.2)
      ]), count:4
    ))
    
    // repeatActionForever:
    turtle.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.moveByX(0, y: CGRectGetHeight(playableRect) * 1/6, duration: 0.2),
        SKAction.moveByX(0, y: -CGRectGetHeight(playableRect) * 1/6, duration: 0.2)
      ])
    ))
    
    label.text = "Repeat Actions / Flip Vertical"
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let transition = SKTransition.flipVerticalWithDuration(1.0)
    let nextScene = FadeScene(size: size)
    nextScene.scaleMode = scaleMode
    view?.presentScene(nextScene, transition: transition)
  }
}

class FadeScene : GameScene {

  override func didMoveToView(view: SKView)  {
    super.didMoveToView(view)
    
    // fadeOutWithDuration() and fadeInWithDuration()
    cat.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.fadeOutWithDuration(1.0),
        SKAction.fadeInWithDuration(1.0)
      ])
    ))
    
    // fadeAlphaBy(duration:)
    dog.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.fadeAlphaBy(-0.75, duration: 1.0),
        SKAction.fadeAlphaBy(0.75, duration: 1.0),
      ])
    ))
    
    // fadeAlphaTo(duration:)
    turtle.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.fadeAlphaTo(0.25, duration: 1.0),
        SKAction.fadeAlphaTo(1.0, duration: 1.0),
      ])
    ))
    
    label.text = "Fade Actions / Reveal"
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let transition = SKTransition.revealWithDirection(.Left, duration:1.0)
    let nextScene = TextureScene(size: size)
    nextScene.scaleMode = scaleMode
    view?.presentScene(nextScene, transition: transition)
  }
}

class TextureScene : GameScene {

  override func didMoveToView(view: SKView)  {
    super.didMoveToView(view)
    
    let catTexture = SKTexture(imageNamed: "cat")
    let dogTexture = SKTexture(imageNamed: "dog")
    let turtleTexture = SKTexture(imageNamed: "turtle")
    
    // setTexture()
    cat.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.setTexture(catTexture),
        SKAction.waitForDuration(0.25),
        SKAction.setTexture(dogTexture),
        SKAction.waitForDuration(0.25),
        SKAction.setTexture(turtleTexture),
        SKAction.waitForDuration(0.25)
      ])
    ))
    
    // animateWithTextures(timePerFrame:)
    let textures = [catTexture, dogTexture, turtleTexture]
    dog.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.animateWithTextures(textures, timePerFrame: 0.25)
      ])
    ))
    
    // animateWithTextures(timePerFrame:resize:restore:)
    turtle.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.animateWithTextures(textures, timePerFrame: 0.25, resize: true, restore: true)
      ])
    ))
    
    label.text = "Texture Actions / Move In"
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let transition = SKTransition.moveInWithDirection(.Left, duration: 1.0)
    let nextScene = SoundRemoveScene(size: size)
    nextScene.scaleMode = scaleMode
    view?.presentScene(nextScene, transition: transition)
  }
}

class SoundRemoveScene : GameScene {

  override func didMoveToView(view: SKView)  {
    super.didMoveToView(view)
    
    // removeFromParent()
    cat.runAction(SKAction.sequence([
      SKAction.waitForDuration(1.0),
      SKAction.removeFromParent()
    ]))
  
    // playSoundFileNamed(waitForCompletion:)
    dog.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.playSoundFileNamed("pew-pew-lei.caf", waitForCompletion: true),
        SKAction.moveByX(0, y: CGRectGetHeight(playableRect) * 1/6, duration: 1.0),
        SKAction.moveByX(0, y: -CGRectGetHeight(playableRect) * 1/6, duration: 1.0),
        SKAction.playSoundFileNamed("pew-pew-lei.caf", waitForCompletion: true),
        SKAction.rotateByAngle(π*2, duration: 1.0)
      ])
    ))
    
    // removeFromParent()
    turtle.runAction(SKAction.sequence([
      SKAction.waitForDuration(1.0),
      SKAction.removeFromParent()
    ]))
    
    label.text = "Sound and Remove Actions / Push"
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let transition = SKTransition.pushWithDirection(.Left, duration: 1.0)
    let nextScene = ColorizeScene(size: size)
    nextScene.scaleMode = scaleMode
    view?.presentScene(nextScene, transition: transition)
  }
}

class ColorizeScene : GameScene {

  override func didMoveToView(view: SKView)  {
    super.didMoveToView(view)
    
    let dogTexture = SKTexture(imageNamed: "dog")
    cat.texture = dogTexture
    turtle.texture = dogTexture
    
    // colorizeWithColor(colorBlendFactor:duration:) and colorizeWithColorBlendFactor(duration:)
    cat.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.colorizeWithColor(SKColor.redColor(), colorBlendFactor: 1.0, duration: 1.0),
        SKAction.colorizeWithColorBlendFactor(0.0, duration: 1.0)
      ])
    ))
    
    dog.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.colorizeWithColor(SKColor.redColor(), colorBlendFactor: 0.25, duration: 1.0),
        SKAction.colorizeWithColorBlendFactor(0.0, duration: 1.0)
      ])
    ))
    
    turtle.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.colorizeWithColor(SKColor.redColor(), colorBlendFactor: 1.0, duration: 1.0),
        SKAction.colorizeWithColorBlendFactor(0.0, duration: 1.0),
        SKAction.colorizeWithColor(SKColor.greenColor(), colorBlendFactor: 1.0, duration: 1.0),
        SKAction.colorizeWithColorBlendFactor(0.0, duration: 1.0),
        SKAction.colorizeWithColor(SKColor.blueColor(), colorBlendFactor: 1.0, duration: 1.0),
        SKAction.colorizeWithColorBlendFactor(0.0, duration: 1.0),
      ])
    ))
    
    label.text = "Colorize Actions / Doors Open"
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let transition = SKTransition.doorsOpenHorizontalWithDuration(1.0)
    let nextScene = FollowScene(size: size)
    nextScene.scaleMode = scaleMode
    view?.presentScene(nextScene, transition: transition)
  }
}

class FollowScene : GameScene {

  override func didMoveToView(view: SKView)  {
    super.didMoveToView(view)
    
    // followPath:duration:
    cat.position = CGPointZero
    let screenBorders = CGPathCreateWithRect(playableRect, nil)
    cat.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.followPath(screenBorders, duration:10.0)
      ])
    ))
    
    // followPath(speed:)
    let stepAmt:CGFloat = 20
    let steps:CGFloat = 5
    let path = CGPathCreateMutable()
    CGPathMoveToPoint(path, nil, CGRectGetMinX(playableRect), CGRectGetMinY(playableRect))
    for i in CGFloat(0).stride(to: steps, by: 1.0) {
      CGPathAddLineToPoint(path, nil, i*stepAmt, (i+1)*stepAmt)
      CGPathAddLineToPoint(path, nil, (i+1)*stepAmt, (i+1)*stepAmt)
    }
    for i in CGFloat(0).stride(to: steps, by: 1.0) {
      CGPathAddLineToPoint(path, nil, (steps-i)*stepAmt, (steps-i-1)*stepAmt)
      CGPathAddLineToPoint(path, nil, (steps-i-1)*stepAmt, (steps-i-1)*stepAmt)
    }
    dog.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.followPath(path, speed: 50.0)
      ])
    ))
    
    // followPath(asOffset:orientToPath:duration:)
    let circle = CGPathCreateWithRoundedRect(CGRect(x: CGRectGetMinX(playableRect), y: CGRectGetMinY(playableRect), width: 400, height: 400), 200, 200, nil)
    turtle.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.followPath(circle, asOffset: false, orientToPath: false, duration: 5.0)
      ])
    ))
    
    label.text = "Follow Actions / Doors Close"
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let transition = SKTransition.doorsCloseHorizontalWithDuration(1.0)
    let nextScene = SpeedScene(size: size)
    nextScene.scaleMode = scaleMode
    view?.presentScene(nextScene, transition: transition)
  }
}

class SpeedScene : GameScene {

  override func didMoveToView(view: SKView)  {
    super.didMoveToView(view)
    
    // speedTo(duration:)
    cat.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.group([
          SKAction.speedTo(5.0, duration:1.0),
          SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * 1/6, duration: 1.0),
        ]),
        SKAction.group([
          SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * -1/6, duration: 1.0),
        ]),
        SKAction.group([
          SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * 1/6, duration: 1.0),
        ]),
        SKAction.group([
        SKAction.speedTo(1.0, duration:1.0),
        SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * -1/6, duration: 1.0),
        ]),
      ])
    ))
    
    dog.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * 1/6, duration: 0.25),
        SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * -1/6, duration: 0.25),
        SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * 1/6, duration: 0.25),
        SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * -1/6, duration: 0.25),
        SKAction.speedTo(0.5, duration:0.1),
        SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * 1/6, duration: 0.25),
        SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * -1/6, duration: 0.25),
        SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * 1/6, duration: 0.25),
        SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * -1/6, duration: 0.25),
        SKAction.speedTo(1.0, duration:1.0),
      ])
    ))
    
    // speedBy(duration:)
    // TODO: BUG??? Getting unexpected behavior on this...
    
    turtle.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * 1/6, duration: 0.25),
        SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * -1/6, duration: 0.25),
        SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * 1/6, duration: 0.25),
        SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * -1/6, duration: 0.25),
        SKAction.speedBy(-0.5, duration:0.1),
        SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * 1/6, duration: 0.25),
        SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * -1/6, duration: 0.25),
        SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * 1/6, duration: 0.25),
        SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * -1/6, duration: 0.25),
        SKAction.speedBy(0.5, duration:1.0),
      ])
    ))
    
    label.text = "Speed Actions / Doorway"
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let transition = SKTransition.doorwayWithDuration(1.0)
    let nextScene = WaitScene(size: size)
    nextScene.scaleMode = scaleMode
    view?.presentScene(nextScene, transition: transition)
  }
}

class WaitScene : GameScene {

  override func didMoveToView(view: SKView)  {
    super.didMoveToView(view)
    
    // waitForDuration()
    cat.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * 1/6, duration: 1.0),
        SKAction.waitForDuration(1.0),
        SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * -1/6, duration: 1.0),
      ])
    ))
    
    // waitForDuration(withRange:)
    dog.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * 1/6, duration: 1.0),
        SKAction.waitForDuration(1.0, withRange:1.0),
        SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * -1/6, duration: 1.0),
      ])
    ))
    
    turtle.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * 1/6, duration: 1.0),
        SKAction.waitForDuration(2.0, withRange:2.0),
        SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * -1/6, duration: 1.0),
      ])
    ))
    
    label.text = "Wait Actions / CIFilter"
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
    let filter = CIFilter(name: "CIDissolveTransition")!
    filter.setDefaults()
    
    let transition = SKTransition(CIFilter: filter, duration: 1.0)
    let nextScene = BlockScene(size: size)
    nextScene.scaleMode = scaleMode
    view?.presentScene(nextScene, transition: transition)
  }
}

class BlockScene : GameScene {

  func rotateCat() {
    cat.runAction(SKAction.rotateByAngle(π*2, duration:1.0))
  }

  override func didMoveToView(view: SKView)  {
    super.didMoveToView(view)
    
    // runBlock()
    cat.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.runBlock(rotateCat),
        SKAction.waitForDuration(2.0)
      ])
    ))
    
    dog.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.runBlock() {
          self.dog.runAction(SKAction.rotateByAngle(π*2, duration:1.0))
        },
        SKAction.waitForDuration(2.0)
      ])
    ))
    
    // runBlock(queue:)
    let queue = dispatch_queue_create("com.razeware.actionscatalog.bgqueue", nil)
    var workDone = true
    turtle.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.runBlock({
          if (workDone) {
            workDone = false
            self.turtle.runAction(SKAction.rotateByAngle(π*2, duration:1.0))
            self.turtle.runAction(SKAction.runBlock({
              sleep(1)
              workDone = true
            }, queue: queue))
          }
        }, queue: queue),
        SKAction.waitForDuration(1.0)
      ])
    ))
    
    label.text = "Block Actions"
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let transition = SKTransition.crossFadeWithDuration(1.0)
    let nextScene = ChildActionsScene(size: size)
    nextScene.scaleMode = scaleMode
    view?.presentScene(nextScene, transition: transition)
  }
}

class ChildActionsScene : GameScene {

  override func didMoveToView(view: SKView)  {
    super.didMoveToView(view)
    
    cat.removeFromParent()
    cat.position = CGPoint(x: size.width * -1/3, y: 0)
    cat.name = "cat"
    dog.addChild(cat)
    
    turtle.removeFromParent()
    turtle.position = CGPoint(x: size.width * 1/3, y: 0)
    turtle.name = "turtle"
    dog.addChild(turtle)
    
    // children affected by action
    dog.runAction(SKAction.repeatActionForever(
      SKAction.rotateByAngle(π*2, duration: 3.0)
    ))
    
    // runAction(onChildWithName:)
    dog.runAction(SKAction.runAction(SKAction.repeatActionForever(
      SKAction.rotateByAngle(π*2, duration: 3.0)
    ), onChildWithName: "cat"))
    
    dog.runAction(SKAction.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.moveByX(-200, y:0, duration:1.0),
        SKAction.moveByX(200, y:0, duration:1.0),
      ])
    ), onChildWithName: "turtle"))
    
    label.text = "Child Actions"
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let transition = SKTransition.crossFadeWithDuration(1.0)
    let nextScene = CustomActionScene(size: size)
    nextScene.scaleMode = scaleMode
    view?.presentScene(nextScene, transition: transition)
  }
}

class CustomActionScene : GameScene {

  override func didMoveToView(view: SKView)  {
    super.didMoveToView(view)
    
    // "Blink" action
    let blinkTimes = 6.0
    let duration = 2.0
    cat.runAction(SKAction.repeatActionForever(
      SKAction.customActionWithDuration(duration) { node, elapsedTime in
        let slice = duration / blinkTimes
        let remainder = Double(elapsedTime) % slice
        node.hidden = remainder > slice / 2
      }
    ))
    
    // "Jump" action
    let dogStart = dog.position
    let jumpHeight = 100.0
    let dogDuration = 2.0
    dog.runAction(SKAction.repeatActionForever(
      SKAction.customActionWithDuration(duration) { node, elapsedTime in
        let fraction = Double(elapsedTime) / dogDuration
        let yOff = jumpHeight * 4 * fraction * (1 - fraction)
        node.position = CGPoint(x: node.position.x, y: dogStart.y + CGFloat(yOff))
      }
    ))
    
    // "Sin wave"
    let turtleStart = turtle.position
    let amplitude = 25.0
    let turtleDuration = 1.0
    turtle.runAction(SKAction.repeatActionForever(
      SKAction.customActionWithDuration(duration) { node, elapsedTime in
        let fraction = Double(elapsedTime) / turtleDuration
        let yOff = sin(M_PI * 2 * fraction) * amplitude
        node.position = CGPoint(x: node.position.x, y: turtleStart.y + CGFloat(yOff))
      }
    ))
    
    label.text = "Custom Actions"
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let transition = SKTransition.crossFadeWithDuration(1.0)
    let nextScene = TimingScene(size: size)
    nextScene.scaleMode = scaleMode
    view?.presentScene(nextScene, transition: transition)
  }
}

class TimingScene : GameScene {

  override func didMoveToView(view: SKView)  {
    super.didMoveToView(view)
    
    // SKActionTimingMode.EaseIn
    let catMoveUp = SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * 1/6, duration: 1.0)
    catMoveUp.timingMode = .EaseIn
    let catMoveDown = catMoveUp.reversedAction()
    cat.runAction(SKAction.repeatActionForever(
      SKAction.sequence([catMoveUp, catMoveDown])
    ))
    
    // SKActionTimingMode.EaseIOut
    let dogMoveUp = SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * 1/6, duration: 1.0)
    dogMoveUp.timingMode = .EaseOut
    let dogMoveDown = catMoveUp.reversedAction()
    dog.runAction(SKAction.repeatActionForever(
      SKAction.sequence([dogMoveUp, dogMoveDown])
    ))
    
    // SKActionTimingMode.EaseInEaseOut
    let turtleMoveUp = SKAction.moveByX(0, y: CGRectGetHeight(self.playableRect) * 1/6, duration: 1.0)
    turtleMoveUp.timingMode = .EaseInEaseOut
    let turtleMoveDown = catMoveUp.reversedAction()
    turtle.runAction(SKAction.repeatActionForever(
      SKAction.sequence([turtleMoveUp, turtleMoveDown])
    ))
    
    label.text = "Timing Actions"
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let transition = SKTransition.crossFadeWithDuration(1.0)
    let nextScene = HideScene(size: size)
    nextScene.scaleMode = scaleMode
    view?.presentScene(nextScene, transition: transition)
  }
}

class HideScene : GameScene {

  override func didMoveToView(view: SKView)  {
    super.didMoveToView(view)
    
    // hide() and unhide()
    cat.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.hide(),
        SKAction.waitForDuration(1.0),
        SKAction.unhide(),
        SKAction.waitForDuration(1.0),
      ])
    ))
    
    dog.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.hide(),
        SKAction.waitForDuration(0.5),
        SKAction.unhide(),
        SKAction.waitForDuration(0.5),
      ])
    ))
    
    turtle.runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.hide(),
        SKAction.waitForDuration(0.1),
        SKAction.unhide(),
        SKAction.waitForDuration(0.1),
      ])
    ))
    
    label.text = "Hide Actions"
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let transition = SKTransition.crossFadeWithDuration(1.0)
    let nextScene = MoveScene(size: size)
    nextScene.scaleMode = scaleMode
    view?.presentScene(nextScene, transition: transition)
  }
}

