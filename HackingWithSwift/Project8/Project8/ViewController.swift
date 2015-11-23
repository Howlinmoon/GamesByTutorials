//
//  ViewController.swift
//  Project8
//
//  Created by jim Veneskey on 11/20/15.
//  Copyright © 2015 Jim Veneskey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var cluesLabel: UILabel!
    
    
    @IBOutlet weak var answersLabel: UILabel!
 
    
    @IBOutlet weak var currentAnswer: UITextField!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    var score = 0
    var level = 1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for subview in view.subviews where subview.tag == 1001 {
            let btn = subview as! UIButton
            letterButtons.append(btn)
            btn.addTarget(self, action: "letterTapped:", forControlEvents: .TouchUpInside)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitTapped(sender: AnyObject) {
    
    }

    @IBAction func clearTapped(sender: AnyObject) {
    
    }
    
    
}

