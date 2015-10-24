//
//  ViewController.swift
//  Project04
//
//  Created by Jim Veneskey on 10/23/15.
//  Copyright © 2015 Jim Veneskey. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "https://www.hackingwithswift.com")!
        webView.loadRequest(NSURLRequest(URL: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

