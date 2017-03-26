//
//  ItemViewController.swift
//  ToDoList
//
//  Created by Paul Binneboese on 3/16/17.
//  Copyright © 2017 Paul Binneboese. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {

    weak var delegate: TableViewController?
    var itemSubject: String = ""
    var itemDescription: String = ""
    var itemDate: String = ""
    
    @IBOutlet weak var SubjectText: UITextField!
    @IBOutlet weak var DescriptionText: UITextField!
    @IBOutlet weak var DateText: UIDatePicker!
    @IBAction func AddItemButtonPressed(_ sender: UIButton) {
        itemSubject = SubjectText.text!
        itemDescription = DescriptionText.text!
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        dateformatter.timeStyle = .none
        dateformatter.dateFormat = "MM/dd/yyyy"
        itemDate = dateformatter.string(from: DateText.date)

        delegate?.itemSaved(by: self)
        let _ = self.navigationController?.viewControllers.popLast()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

