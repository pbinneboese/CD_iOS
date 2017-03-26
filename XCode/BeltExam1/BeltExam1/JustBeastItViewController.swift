//
//  JustBeastItViewController.swift
//  BeltExam1
//
//  Created by Paul Binneboese on 3/24/17.
//  Copyright © 2017 Paul Binneboese. All rights reserved.
//

import UIKit

class JustBeastItViewController: UIViewController {

    weak var delegate: ToBeastViewController?
    var newItem: Bool?
    var itemString: String?
    var indexPath: NSIndexPath?
    
    @IBOutlet weak var ItemText: UITextField!
    
    @IBAction func CancelButton(_ sender: UIBarButtonItem) {
        let _ = self.navigationController?.viewControllers.popLast()
    }
    @IBAction func DoneButton(_ sender: UIBarButtonItem) {
        itemString = ItemText.text
        delegate?.itemSaved(by: self, newItem: newItem!)
        let _ = self.navigationController?.viewControllers.popLast()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ItemText.text = itemString

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
