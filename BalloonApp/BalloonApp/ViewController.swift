//
//  ViewController.swift
//  BalloonApp
//
//  Created by Taylor Schmidt on 2/3/15.
//  Copyright (c) 2015 Taylor Schmidt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 1.0, alpha: 1.0)
    }
    
    override func viewDidAppear(animated: Bool) {
        let balloon: UIImage? = UIImage(named: "balloon_red.png")
        let button: UIButton = UIButton(frame: self.view.frame)
        
        button.setImage(balloon, forState: UIControlState.Normal)
        button.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
        button.center = CGPoint(x: button.center.x, y: button.center.y + 100)
        
        button.addTarget(self, action: "addHelium:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
        self.view.addSubview(button)

    }
    func addHelium(sender: UIButton) {
        println("Called! w00p")

        UIView.animateWithDuration(1, animations: {sender.center = CGPoint(x: sender.center.x, y: sender.center.y - 200)}) {
            (completed: Bool) in
            if completed {
                UIView.animateWithDuration(1, animations: {sender.center = CGPoint(x: sender.center.x, y: sender.center.y + 200)}) {
                    (completed: Bool) in
                    if completed {
                        self.addHelium(sender)
                    }
                }
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

