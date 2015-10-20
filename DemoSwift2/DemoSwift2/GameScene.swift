//
//  GameScene.swift
//  DemoSwift2
//
//  Created by Jim Veneskey on 10/17/15.
//  Copyright (c) 2015 Jim Veneskey. All rights reserved.
//

import SpriteKit

var hillDifficulty = ["Haunted Mansion": 1,
                      "The Castle": 2,
                      "Thunder Mountain": 40]


func lookUpDifficulty(thePlace: String) -> Int {
    var diff:Int = 0
    
    for (key, value) in hillDifficulty {
        
        if thePlace == key {
            diff = value
        }
    }
    
    return diff
}


var myArray:Array = ["Darth Vader", "Luke", "Han", "Leia"]

enum Direction:String {
    case North = "toward the village"
    case South = "toward Mordor"
    case East = "toward Rivendale"
    case West = "to where the elves are from"
}


class GameScene: SKScene {
    
    var myNumber: Int = 10
    var myString: String?
    var anotherString: String?
    var resultString: String = ""
    var directionText:String = "You are heading "
    var currentDirection = Direction.West
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        
        
        
        
        
        // Add a few names
        myArray.append("Grand Moff Tarken")
        myArray.append("Yoda")
        myArray.append("Londo")
        
        for name in myArray {
            print("Current Name: \(name)")
        }
        
        print( myArray[0])
        
        hillDifficulty["Buzz Ride"] = 2

        let rideName = "Buzz Ride"
        let theDifficulty = lookUpDifficulty("Buzz Ride")
        print("\(rideName)'s difficulty is: \(theDifficulty)")
        
        
        /*
        //print(directionText + Direction.North.rawValue)

        switch ( currentDirection ) {
        case .North:
            print(directionText + Direction.North.rawValue)
        case .South:
            print(directionText + Direction.South.rawValue)
        case .West:
            print(directionText + Direction.West.rawValue)
        case .East:
            print(directionText + Direction.East.rawValue)
            
        }
        */
        
        
        /*
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
        */
        
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
