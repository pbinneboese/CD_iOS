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

    var ToBeastItems = [BeastItem]()      // items on ToBeast list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchToBeastItems()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        fetchToBeastItems()
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
        cell.item = ToBeastItems[indexPath.row]
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
        fetchToBeastItems()
    }
    
    // press Delete (swipe)
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = ToBeastItems[indexPath.row]
        print("Delete item \(item.item)")
        deleteItemfromDB(item)
        fetchToBeastItems()
    }

    // Tap cell - edit contents
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItem", sender: indexPath)
    }

    // Beast Button press - move item to Beasted list
    func didPressBeastButton(_ item: BeastItem) {
        print("Moving item \(item.item) to Beasted")
        item.beasted = true
        item.beastDate = Date() as NSDate?
        updateItemtoDB(item)
        fetchToBeastItems()
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
        do {    // save the item into db
            try dbContext.save()
        } catch {
            print("DB \(error)")
        }
    }
    
    func updateItemtoDB(_ item: BeastItem) {
        if dbContext.hasChanges {
            do {    // save the item into db
                try dbContext.save()
            } catch {
                print("DB \(error)")
            }
        }
    }
    
    func deleteItemfromDB(_ item: BeastItem) {
        dbContext.delete(item)
        do {
            try dbContext.save()
        } catch {
            print("DB \(error)")
        }
    }
    
    
    func fetchToBeastItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BeastItem")
        request.predicate = NSPredicate(format: "beasted == %@", false as CVarArg)

        do {
            let result = try dbContext.fetch(request)
            ToBeastItems = result as! [BeastItem]
        } catch {
            print("DB \(error)")
        }
        self.tableView.reloadData()
    }
    
}
