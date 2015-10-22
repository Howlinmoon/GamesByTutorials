//
//  ViewController.swift
//  Project02
//
//  Created by jim Veneskey on 10/21/15.
//  Copyright © 2015 Jim Veneskey. All rights reserved.
//

import GameplayKit
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // initialize our array of country names
countries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        askQuestion()
        
        // give the buttons a border
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        // change the border color to gray
        // .CGColor 'casts' the resulting UIColor into a CGColor...
        button1.layer.borderColor = UIColor.lightGrayColor().CGColor
        button2.layer.borderColor = UIColor.lightGrayColor().CGColor
        button3.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        
    }

    func askQuestion() {
        // re-shuffle the array prior to selecting the first, second and third entries.
        countries = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(countries) as! [String]
        // we are always selecting the first, second and third entries - but the source has been
        // randomized, so the values we get are actually at random...
        button1.setImage(UIImage(named: countries[0]), forState: .Normal)
        button2.setImage(UIImage(named: countries[1]), forState: .Normal)
        button3.setImage(UIImage(named: countries[2]), forState: .Normal)
        // Select which is the 'correct' flag (randomizes 0, 1 or 2)
        correctAnswer = GKRandomSource.sharedRandom().nextIntWithUpperBound(3)
        // Set our current title to the name of the correct flag's country
        title = countries[correctAnswer].uppercaseString
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

