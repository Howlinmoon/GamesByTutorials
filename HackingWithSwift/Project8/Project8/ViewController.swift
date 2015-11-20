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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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

