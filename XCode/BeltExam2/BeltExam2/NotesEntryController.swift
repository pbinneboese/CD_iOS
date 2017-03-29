//
//  NotesEntryController.swift
//  BeltExam2
//
//  Created by Paul Binneboese on 3/28/17.
//  Copyright © 2017 Paul Binneboese. All rights reserved.
//

import UIKit

class NotesEntryController: UIViewController {

    weak var delegate: NotesViewController?
    var textString: String?
    var indexPath: NSIndexPath?
    var newItem: Bool?

    @IBOutlet weak var noteText: UITextView!

    @IBAction func BackButton(_ sender: UIBarButtonItem) {
        textString = noteText.text
        delegate?.itemSaved(by: self, newItem: newItem!)
        let _ = self.navigationController?.viewControllers.popLast()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        noteText.text = textString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

