//
//  AddItemTableViewControllerDelegate.swift
//  bucketList
//
//  Created by Paul Binneboese on 3/14/17.
//  Copyright © 2017 Paul Binneboese. All rights reserved.
//

import UIKit

protocol AddItemTableViewControllerDelegate: class {
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?)
    func cancelButtonPressed(by controller: AddItemTableViewController)
}
