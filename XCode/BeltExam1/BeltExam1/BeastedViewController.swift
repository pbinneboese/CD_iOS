//
//  BeastedViewController.swift
//  BeltExam1
//
//  Created by Paul Binneboese on 3/24/17.
//  Copyright © 2017 Paul Binneboese. All rights reserved.
//

import UIKit
import CoreData

class BeastedViewController: UITableViewController {

    var BeastedItems = [BeastItem]()      // items on Beasted list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBeastedItems()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        fetchBeastedItems()
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
            dateformatter.dateFormat = "MMM dd, yyyy"
            let itemDateString = dateformatter.string(from: itemDate as Date)
            cell.detailTextLabel?.text = itemDateString
        }
//        print("cell \(indexPath.row)")
        return cell
    }

    // press Delete (swipe)
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = BeastedItems[indexPath.row]
        print("Delete item \(item.item)")
        deleteItemfromDB(item)
        fetchBeastedItems()
    }
    
    //
    // DATABASE FUNCTIONS
    //
    
    // open access to db context
    let dbContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func deleteItemfromDB(_ item: BeastItem) {
        dbContext.delete(item)
        do {
            try dbContext.save()
        } catch {
            print("DB \(error)")
        }
    }

    func fetchBeastedItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BeastItem")
        request.predicate = NSPredicate(format: "beasted == %@", true as CVarArg)
        do {
            let result = try dbContext.fetch(request)
            BeastedItems = result as! [BeastItem]
        } catch {
            print("DB \(error)")
        }
        self.tableView.reloadData()
    }

}
