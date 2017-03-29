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
    var item = BeastItem()   // default with a dummy item

    @IBAction func BeastButton(_ sender: UIButton) {
        cellDelegate?.didPressBeastButton(self.item)
    }
    @IBOutlet weak var ItemText: UILabel!
    
}

protocol ToBeastCellDelegate: class {
    func didPressBeastButton(_ item: BeastItem)
}
