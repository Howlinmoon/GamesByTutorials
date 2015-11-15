import UIKit
import SpriteKit
import XCPlayground

let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 480, height:320))
let scene = SKScene(size: CGSize(width: 480, height: 320))
sceneView.showsFPS = true
sceneView.presentScene(scene)
XCPShowView("My Scene", view: sceneView)
