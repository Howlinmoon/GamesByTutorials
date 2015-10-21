//
//  DetailViewController.swift
//  Project01
//
//  Created by jim Veneskey on 10/20/15.
//  Copyright © 2015 Jim Veneskey. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

   
    @IBOutlet weak var detailImageView: UIImageView!


    var detailItem: String? {
        // property observer
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let imageView = self.detailImageView {
                imageView.image = UIImage(named: detail)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

