//
//  GameScene.swift
//  DemoSwift2
//
//  Created by Jim Veneskey on 10/17/15.
//  Copyright (c) 2015 Jim Veneskey. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var myNumber: Int = 10
    var myString: String?
    var anotherString: String?
    var resultString: String = ""
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        //myString = "Optionals are Fun!"
        
        print(myNumber)
        //print(myString!)
        
        if let anotherString = myString {
            print(anotherString)
        } else {
            print("myString must be nil")
        }
        
        resultString = lookupUser("Joe Cool")
        print("Lookup result for user is: \(resultString)")
        
        
    }
    
    func lookupUser(someUser: String) -> String {
        print("Currently looking up user: \(someUser)")
        return "The user was not found"
    }
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins
        for touch in touches {
            
            print(myNumber)
            print(myString)

            
            
        } */
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
