//
//  ToBeastCell.swift
//  BeltExam1
//
//  Created by Paul Binneboese on 3/24/17.
//  Copyright © 2017 Paul Binneboese. All rights reserved.
//

import UIKit

class ToBeastCell: UITableViewCell {
    weak var cellDelegate: ToBeastCellDelegate?

    @IBAction func BeastButton(_ sender: UIButton) {
        cellDelegate?.didPressBeastButton(sender.tag)
    }
    @IBOutlet weak var ItemText: UILabel!
    
}

protocol ToBeastCellDelegate: class {
    func didPressBeastButton(_ tag: Int)
}
