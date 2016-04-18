//
//  ViewController.swift
//  SubtitleView
//
//  Created by Lawrence Tran on 04/15/2016.
//  Copyright (c) 2016 Lawrence Tran. All rights reserved.
//

import UIKit
import SubtitleView

class ViewController: UIViewController {

    var imageView: UIImageView!
    var subtitleView: SubtitleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.width)
         let frame = CGRect(x: 37.5, y: 80, width: 300, height: 300)
        self.imageView = UIImageView(frame: frame)
        self.imageView.image = UIImage(named: "test.gif")
        self.subtitleView = SubtitleView(frame: frame)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.view.addSubview(self.imageView)
        self.view.addSubview(self.subtitleView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func donePressed(sender: AnyObject) {
    
    }
}

