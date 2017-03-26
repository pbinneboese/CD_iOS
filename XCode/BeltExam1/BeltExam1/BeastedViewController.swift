//
//  BeastedViewController.swift
//  BeltExam1
//
//  Created by Paul Binneboese on 3/24/17.
//  Copyright © 2017 Paul Binneboese. All rights reserved.
//

import UIKit

class BeastedViewController: UITableViewController {

//    let TBVC = ToBeastViewController.self
    weak var TBVC: ToBeastViewController?
    
//    let BeastedItems = TBVC.BeastedItems
//    weak var BeastedItems: TBVC.BeastedItems?      // those on Beasted list
    
    var BeastedItems = [BeastItem]()      // those on Beasted list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TBVC?.rebuildBeastList()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BeastedItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeastedCell", for: indexPath)
        cell.textLabel?.text = BeastedItems[indexPath.row].item
        if let itemDate = BeastedItems[indexPath.row].beastDate {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            dateformatter.timeStyle = .none
            dateformatter.dateFormat = "MM/dd/yyyy"
            let itemDateString = dateformatter.string(from: itemDate as Date)
            cell.detailTextLabel?.text = itemDateString
        }
        return cell
    }

    // press Delete (swipe)
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = BeastedItems[indexPath.row]
        TBVC?.deleteItemfromDB(item)
        TBVC?.rebuildBeastList()
    }
    
}
