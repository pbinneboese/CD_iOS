//
//  SecondViewController.swift
//  segueDemo
//
//  Created by Dylan Sharkey on 3/13/17.
//  Copyright © 2017 Dylan Sharkey. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var labelOutlet: UILabel!
    var data: String?
    
    override func viewDidLoad() {
        labelOutlet.text = data
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
