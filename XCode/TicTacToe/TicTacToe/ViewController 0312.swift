//
//  ViewController.swift
//  TicTacToe
//
//  Created by Paul Binneboese on 3/9/17.
//  Copyright © 2017 Paul Binneboese. All rights reserved.
//

import UIKit

// color codes: 0 = none, 1 = red, 2 = blue
var currentPlayer = UIColor.red  // Start with player RED
var winningPlayer = UIColor.lightGray

class ViewController: UIViewController {

    //Instance Variables
    var buttonColor:[UIColor] = [UIColor.lightGray, UIColor.lightGray, UIColor.lightGray, UIColor.lightGray, UIColor.lightGray, UIColor.lightGray,UIColor.lightGray, UIColor.lightGray, UIColor.lightGray, UIColor.lightGray]

    //Outlets

    @IBOutlet weak var Winner: UILabel!
    
    //Init function
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.restartGame()
    }

    //Button actions

    @IBAction func Reset(_ sender: UIButton) {
        self.restartGame()
    }
    
    @IBAction func B1(_ sender: UIButton) {
        sender.backgroundColor = self.toggleButton(bval:1)
    }
    
    @IBAction func B2(_ sender: UIButton) {
        sender.backgroundColor = self.toggleButton(bval:2)
    }
    
    @IBAction func B3(_ sender: UIButton) {
        sender.backgroundColor = self.toggleButton(bval:3)
    }
    
    @IBAction func B4(_ sender: UIButton) {
        sender.backgroundColor = self.toggleButton(bval:4)
    }
    
    @IBAction func B5(_ sender: UIButton) {
        sender.backgroundColor = self.toggleButton(bval:5)
    }
    
    @IBAction func B6(_ sender: UIButton) {
        sender.backgroundColor = self.toggleButton(bval:6)
    }
    
    @IBAction func B7(_ sender: UIButton) {
        sender.backgroundColor = self.toggleButton(bval:7)
    }

    @IBAction func B8(_ sender: UIButton) {
        sender.backgroundColor = self.toggleButton(bval:8)
    }
    
    @IBAction func B9(_ sender: UIButton) {
        sender.backgroundColor = self.toggleButton(bval:9)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func restartGame() {
        for i in 1...9 {  // reset button colors
            self.buttonColor[i] = UIColor.lightGray
        }
//        UIButton.B1.backgroundColor = UIColor.lightGray
        currentPlayer = (currentPlayer == UIColor.red) ? UIColor.blue : UIColor.red  // toggle current player
        winningPlayer = UIColor.lightGray
        self.Winner.text = ""
    }
    
    func toggleButton(bval:Int) -> UIColor {
        if buttonColor[bval] == UIColor.lightGray {  // not yet played
            buttonColor[bval] = currentPlayer  // mark as played
            currentPlayer = (currentPlayer == UIColor.red) ? UIColor.blue : UIColor.red  // toggle current player
        }
        self.checkWinner()
        return buttonColor[bval]
    }

    func checkWinner() {  // Check for winner: 3 in a row/column
        var theWinner = ""
        
        if (buttonColor[1] == currentPlayer && buttonColor[2] == currentPlayer) && (buttonColor[3] == currentPlayer) ||
        (buttonColor[4] == currentPlayer && buttonColor[5] == currentPlayer) && (buttonColor[6] == currentPlayer) ||
            (buttonColor[7] == currentPlayer && buttonColor[8] == currentPlayer) && (buttonColor[9] == currentPlayer) ||
            (buttonColor[1] == currentPlayer && buttonColor[4] == currentPlayer) && (buttonColor[7] == currentPlayer) ||
            (buttonColor[2] == currentPlayer && buttonColor[5] == currentPlayer) && (buttonColor[8] == currentPlayer) ||
            (buttonColor[3] == currentPlayer && buttonColor[6] == currentPlayer) && (buttonColor[9] == currentPlayer) {
            winningPlayer = currentPlayer
            theWinner = (winningPlayer == UIColor.red) ? "Red" : "Blue"
            self.Winner.text = "Congrats \(theWinner) Won"
        }
    }

}

