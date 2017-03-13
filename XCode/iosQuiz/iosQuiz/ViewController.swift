//
//  ViewController.swift
//  iosQuiz
//
//  Created by Paul Binneboese on 3/8/17.
//  Copyright © 2017 Paul Binneboese. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var names:[String] = ["Aaron", "Bobby", "Carmela", "Delilah", "Edwin", "Fernando", "Gabriel", "Hugo"]
    @IBOutlet weak var theName: UILabel!
    @IBOutlet weak var theNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        theName.text = "READY?"
    }

    @IBAction func callButton(_ sender: UIButton) {
        var i = Int(arc4random_uniform(UInt32(names.count)))
        theName.text = names[i]
        i = Int(arc4random_uniform(UInt32(5))+1)
        theNumber.text = String(i)
        if i==1 || i==2 {
            theNumber.textColor = UIColor.red
        }
        else if i==3 || i==4 {
            theNumber.textColor = UIColor.orange
            
        }
        else {
            theNumber.textColor = UIColor.green
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

