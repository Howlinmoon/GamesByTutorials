//
//  ViewController.swift
//  Project8
//
//  Created by jim Veneskey on 11/20/15.
//  Copyright © 2015 Jim Veneskey. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UIViewController {

    
    @IBOutlet weak var cluesLabel: UILabel!
    
    
    @IBOutlet weak var answersLabel: UILabel!
 
    
    @IBOutlet weak var currentAnswer: UITextField!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    var level = 1
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for subview in view.subviews where subview.tag == 1001 {
            let btn = subview as! UIButton
            letterButtons.append(btn)
            btn.addTarget(self, action: "letterTapped:", forControlEvents: .TouchUpInside)
        }
        loadLevel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitTapped(sender: AnyObject) {
        if let solutionPosition = self.solutions.indexOf(self.currentAnswer.text!) {
            self.activatedButtons.removeAll()
            
            var splitClues = self.answersLabel.text!.componentsSeparatedByString("\n")
            splitClues[solutionPosition] = self.currentAnswer.text!
            self.answersLabel.text = splitClues.joinWithSeparator("\n")
            
            self.currentAnswer.text = ""
            ++self.score
            
            if self.score % 14 == 0 {
                let actionController = UIAlertController(title: "Congratulations!", message: "You've completed both levels!", preferredStyle: UIAlertControllerStyle.Alert)
                actionController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(actionController, animated: true, completion: nil)
                self.level = 1
                self.score = 0
            }
            else if self.score % 7 == 0 {
                let actionController = UIAlertController(title: "Easy as pie, right!", message: "Are you ready for the next level?", preferredStyle: UIAlertControllerStyle.Alert)
                actionController.addAction(UIAlertAction(title: "Let's go!!", style: UIAlertActionStyle.Default, handler: levelUp))
                self.presentViewController(actionController, animated: true, completion: nil)
            }
        }
    }

    @IBAction func clearTapped(sender: AnyObject) {
        currentAnswer.text = ""
        
        for btn in activatedButtons {
            btn.hidden = false
        }
        
        activatedButtons.removeAll()
    }
    
    
    func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        if let levelFilePath = NSBundle.mainBundle().pathForResource("level\(level)", ofType: "txt") {
        if let levelContents = try? String(contentsOfFile: levelFilePath, usedEncoding: nil) {
            var lines = levelContents.componentsSeparatedByString("\n")
            lines = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(lines) as! [String]
            
            for (index, line) in lines.enumerate() {
                print("current line: \(line)")
                let parts = line.componentsSeparatedByString(": ")
                let answer = parts[0]
                let clue = parts[1]
                
                clueString += "\(index + 1).\(clue)\n"
                
                let solutionWord = answer.stringByReplacingOccurrencesOfString("|", withString: "")
                solutionString += "\(solutionWord.characters.count) letters\n"
                solutions.append(solutionWord)
                
                let bits = answer.componentsSeparatedByString("|")
                letterBits += bits
            }
        }
    }
    
    cluesLabel.text = clueString.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
    answersLabel.text = solutionString.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
        
    letterBits = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(letterBits) as! [String]
    letterButtons = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(letterButtons) as! [UIButton]
        
    if letterBits.count == letterButtons.count {
        for i in 0 ..< letterBits.count {
            letterButtons[i].setTitle(letterBits[i], forState: .Normal)
        }
    }
}
    func letterTapped(btn: UIButton) {
        currentAnswer.text = currentAnswer.text! + btn.titleLabel!.text!
        activatedButtons.append(btn)
        btn.hidden = true
    }
    
    
    func levelUp(action: UIAlertAction!) {
        ++level
        solutions.removeAll(keepCapacity: true)
        
        loadLevel()
        
        for btn in letterButtons {
            btn.hidden = false
        }
    }
    
}

