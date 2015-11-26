//
//  ViewController.swift
//  Project06b
//
//  Created by jim Veneskey on 10/27/15.
//  Copyright © 2015 Jim Veneskey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = UIColor.redColor()
        label1.text = "THESE"
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = UIColor.cyanColor()
        label2.text = "ARE"
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = UIColor.yellowColor()
        label3.text = "SOME"
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = UIColor.greenColor()
        label4.text = "AWESOME"
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = UIColor.orangeColor()
        label5.text = "LABELS"
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
        let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
        
        // long way
        /*
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[label1]|", options: [], metrics: nil, views: viewsDictionary))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[label2]|", options: [], metrics: nil, views: viewsDictionary))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[label3]|", options: [], metrics: nil, views: viewsDictionary))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[label4]|", options: [], metrics: nil, views: viewsDictionary))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[label5]|", options: [], metrics: nil, views: viewsDictionary))
        */
        
        // efficient way
        
        for label in viewsDictionary.keys {
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
        }
        
        /* From www.hackingwithswift.com
        The H: parts means that we're defining a horizontal layout; we'll do a vertical layout soon. The pipe symbol, |, means "the edge of the view." We're adding these constraints to the main view inside our view controller, so this effectively means "the edge of the view controller." Finally, we have [label1], which is a visual way of saying "put label1 here". Imagine the brackets, [ and ], are the edges of the view.
        
        */
        
        /* Default vertical constraint spacing
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[label1]-[label2]-[label3]-[label4]-[label5]", options: [], metrics: nil, views: viewsDictionary))
        
        //overriding the default vertical constraint spacing
        // 88 pix height per label, min 10 pix at the bottom
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[label1(==88)]-[label2(==88)]-[label3(==88)]-[label4(==88)]-[label5(==88)]-(>=10)-|", options: [], metrics: nil, views: viewsDictionary))

        
        // using the metrics dictionary to make resizing easier
        let metrics = ["labelHeight": 88]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[label1(labelHeight)]-[label2(labelHeight)]-[label3(labelHeight)]-[label4(labelHeight)]-[label5(labelHeight)]->=10-|", options: [], metrics: metrics, views: viewsDictionary))
        */

        // Finally - adding priorities to allow auto-resizing in landscape mode
        let metrics = ["labelHeight": 88]
         view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]->=10-|", options: [], metrics: metrics, views: viewsDictionary))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // Hide the status bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

