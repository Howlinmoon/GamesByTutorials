import UIKit
import SpriteKit
import XCPlayground

let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 480, height:320))
let scene = SKScene(size: CGSize(width: 480, height: 320))
sceneView.showsFPS = true
// disable gravity
scene.physicsWorld.gravity = CGVector(dx:0, dy: 0)
sceneView.presentScene(scene)

XCPlaygroundPage.currentPage.liveView = sceneView

let square = SKSpriteNode(imageNamed: "square")
square.name = "shape"
square.position = CGPoint(x: scene.size.width * 0.25, y: scene.size.height * 0.50)

let circle = SKSpriteNode(imageNamed: "circle")
circle.name = "shape"
circle.position = CGPoint(x: scene.size.width * 0.50, y: scene.size.height * 0.50)

let triangle = SKSpriteNode(imageNamed: "triangle")
triangle.position = CGPoint(x: scene.size.width * 0.75, y: scene.size.height * 0.50)

scene.addChild(square)
scene.addChild(circle)
scene.addChild(triangle)

// Playing with Physics
circle.physicsBody = SKPhysicsBody(circleOfRadius: circle.size.width/2)


// Re-Enable Gravity
delay(seconds: 2.0, completion: { scene.physicsWorld.gravity = CGVector(dx:0, dy: -9.8)
})

