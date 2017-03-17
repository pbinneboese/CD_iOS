//
//  ViewController.swift
//  segueDemo
//
//  Created by Dylan Sharkey on 3/13/17.
//  Copyright © 2017 Dylan Sharkey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var infoTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        infoTextField.text = ""
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendInfoButtonPressed(_ sender: UIButton) {
        //Go To other page
        performSegue(withIdentifier: "sendDataSegue", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "sendDataSegue") {
            let destinationViewController = segue.destination as! SecondViewController
            destinationViewController.data = infoTextField.text!
        }
    }

}

