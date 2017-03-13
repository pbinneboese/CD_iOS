//
//  ViewController.swift
//  TicTacToe
//
//  Created by Paul Binneboese on 3/9/17.
//  Copyright © 2017 Paul Binneboese. All rights reserved.
//

import UIKit

// color codes: 0 = none, 1 = red, 2 = blue
var currentPlayer = 1  // Start with player RED
var winningPlayer = 0

class ViewController: UIViewController {

    //Instance Variables
    var buttonPlayer:[Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0]

    //Outlets

    @IBOutlet weak var Winner: UILabel!
    
    @IBOutlet var ButtonCollection: [UIButton]!
    
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
    
    @IBAction func ButtonAction(_ sender: UIButton) {
        ButtonCollection[sender.tag].backgroundColor = self.toggleButton(bval: sender.tag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func restartGame() {
        for i in 0..<9 {  // reset button colors
            buttonPlayer[i] = 0
            ButtonCollection[i].backgroundColor = UIColor.lightGray
        }
        currentPlayer = (currentPlayer == 1) ? 2 : 1  // toggle current player
        winningPlayer = 0
        self.Winner.text = ""
    }
    
    func toggleButton(bval:Int) -> UIColor {
        if buttonPlayer[bval] == 0 {  // not yet played
            buttonPlayer[bval] = currentPlayer  // mark as played
            self.checkWinner()  // check if this player wins
            currentPlayer = (currentPlayer == 1) ? 2 : 1  // toggle current player
        }
        return (buttonPlayer[bval] == 1) ? UIColor.red : UIColor.blue
    }

    func checkWinner() {  // Check for winner: 3 in a row/column
        var theWinner = ""
        
        if winningPlayer != 0 {   // stop when a winner has been declared
            return
        }
        if (buttonPlayer[0] == currentPlayer && buttonPlayer[1] == currentPlayer) && (buttonPlayer[2] == currentPlayer) ||
        (buttonPlayer[3] == currentPlayer && buttonPlayer[4] == currentPlayer) && (buttonPlayer[5] == currentPlayer) ||
            (buttonPlayer[6] == currentPlayer && buttonPlayer[7] == currentPlayer) && (buttonPlayer[8] == currentPlayer) ||
            (buttonPlayer[0] == currentPlayer && buttonPlayer[3] == currentPlayer) && (buttonPlayer[6] == currentPlayer) ||
            (buttonPlayer[1] == currentPlayer && buttonPlayer[4] == currentPlayer) && (buttonPlayer[7] == currentPlayer) ||
            (buttonPlayer[2] == currentPlayer && buttonPlayer[5] == currentPlayer) && (buttonPlayer[8] == currentPlayer) {
            winningPlayer = currentPlayer
            theWinner = (winningPlayer == 1) ? "Red" : "Blue"
            self.Winner.text = "Congrats \(theWinner) Won"
        }
    }

}

