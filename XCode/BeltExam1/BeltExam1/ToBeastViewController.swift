//
//  ToBeastViewController.swift
//  BeltExam1
//
//  Created by Paul Binneboese on 3/24/17.
//  Copyright © 2017 Paul Binneboese. All rights reserved.
//

import UIKit
import CoreData

class ToBeastViewController: UITableViewController, ToBeastCellDelegate {

    var AllBeastItems = [BeastItem]()      // all items from ToBeast and Beasted lists
    var ToBeastItems = [BeastItem]()      // those on ToBeast list
    var BeastedItems = [BeastItem]()      // those on Beasted list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
        rebuildBeastList()
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
        return ToBeastItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToBeastCell", for: indexPath) as! ToBeastCell
        cell.cellDelegate = self
        cell.tag = indexPath.row
        cell.ItemText.text = ToBeastItems[indexPath.row].item
//        print("cell \(indexPath.row)")
        return cell
    }
    
    // Save button pressed (from JustBeastIt view)
    func itemSaved(by controller: JustBeastItViewController, newItem: Bool) {
        if newItem {    // added new item
            let item = getNewItem()
            item.item = controller.itemString
            item.beasted = false
            item.beastDate = nil
            print("Add item \(item.item)")
            addItemtoDB(item)
        }
        else {  // edited existing item
            print("Edit item \(controller.itemString)")
            if let indexPath = controller.indexPath {
                let item = ToBeastItems[indexPath.row]
                item.item = controller.itemString
                updateItemtoDB(item)
            }
        }
        rebuildBeastList()
    }
    
    // press Delete (swipe)
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = ToBeastItems[indexPath.row]
        deleteItemfromDB(item)
        rebuildBeastList()
    }

    // Tap cell - edit contents
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItem", sender: indexPath)
    }

    // Beast Button press - move item to Beasted list
    func didPressBeastButton(_ tag: Int) {
        print("Moving item \(tag) to Beasted")
        let item = ToBeastItems[tag]
        item.beasted = true
        item.beastDate = Date() as NSDate?
        updateItemtoDB(item)
        rebuildBeastList()
    }

    // segue to JustBeastIt View
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let JBIVC = segue.destination as! JustBeastItViewController
        JBIVC.delegate = self
        if segue.identifier == "AddNewItem" {   // creating a new item
            let JBIVC = segue.destination as! JustBeastItViewController
            JBIVC.itemString = ""
            JBIVC.indexPath = nil
            JBIVC.newItem = true
        }
        else {  // editing an existing item
            let indexPath = sender as! NSIndexPath
            JBIVC.itemString = ToBeastItems[indexPath.row].item
            JBIVC.indexPath = indexPath
            JBIVC.newItem = false
        }
    }
    
    func rebuildBeastList() {
        // first, remove all items from ToBeastList and BeastedList
        ToBeastItems.removeAll()
        BeastedItems.removeAll()
        // now, rebuild ToBeastList and BeastedList
        for i in 0..<AllBeastItems.count {  // place in the appropriate BeastList
            let item = AllBeastItems[i]
            if item.beasted == false {
                ToBeastItems.append(item)
                print("t1 \(item.item!)")
            }
            else {
                BeastedItems.append(item)
                print("t2 \(item.item!)")
            }
            self.tableView.reloadData()
        }
    }
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */


    //
    // DATABASE FUNCTIONS
    //

    // open access to db context
    let dbContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    func getNewItem() -> BeastItem {
        let item = BeastItem(context: dbContext)
        return item
    }
    
    func addItemtoDB(_ item: BeastItem) {
        item.beasted = false
        item.beastDate = nil
        item.itemNumber = Int64(AllBeastItems.count)    // not really used in db
        AllBeastItems.append(item)
        
        do {    // save the item into db
            try dbContext.save()
        } catch {
            print("DB \(error)")
        }
    }
    
    func updateItemtoDB(_ item: BeastItem) {
        AllBeastItems[Int(item.itemNumber)] = item
        do {    // save the item into db
            try dbContext.save()
        } catch {
            print("DB \(error)")
        }
    }
    
    func deleteItemfromDB(_ item: BeastItem) {
        let itemNumber = Int(item.itemNumber)
        dbContext.delete(AllBeastItems[itemNumber])
        do {
            try dbContext.save()
        } catch {
            print("DB \(error)")
        }
        AllBeastItems.remove(at: itemNumber)
        for i in 0..<AllBeastItems.count {  // renumber these
            AllBeastItems[i].itemNumber = Int64(i)
        }
    }
    
    
    func fetchAllItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BeastItem")
        do {    // fetch all items from db, place in AllBeastItems[] array
            let result = try dbContext.fetch(request)
            AllBeastItems = result as! [BeastItem]
        } catch {
            print("DB \(error)")
        }
        for i in 0..<AllBeastItems.count {  // renumber these
            AllBeastItems[i].itemNumber = Int64(i)
        }
    }
    
}
