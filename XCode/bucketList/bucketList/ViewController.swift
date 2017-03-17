//
//  ViewController.swift
//  bucketList
//
//  Created by Paul Binneboese on 3/13/17.
//  Copyright © 2017 Paul Binneboese. All rights reserved.
//

import UIKit
import CoreData

class BucketViewController: UITableViewController, AddItemTableViewControllerDelegate {

    var items = [BucketListItem]()

    // open access to db context
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBAction func AddNewItem(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "EditItem", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // count number of bucket-list items
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    // return text of item <indexPath>
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeue cell from storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath)
        // update cells' text from item list
        cell.textLabel?.text = items[indexPath.row].text!
        return cell
    }

    // press Edit (accessory) button
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItem", sender: indexPath)
    }

    // press Delete (swipe)
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {    // remove item from db
        let item = items[indexPath.row]
        managedObjectContext.delete(item)
        do {    // update db with changes
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }

    // segue to AddItem TableView
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let addItemTableController = navigationController.topViewController as! AddItemTableViewController
        addItemTableController.delegate = self

//        unfinished code for eliminating 2nd segue and using sender instead
//        let source = sender as! UIBarItem
//        do {
//            let tagID = try (sender as! UIBarItem).tag
//            // Adding new item using navbar Add Button
//        } catch {
//            // Editing item, pass in item text & index
//            let indexPath = sender as! NSIndexPath
//            let itemString = items[indexPath.row]
//            addItemTableController.itemString = itemString
//            addItemTableController.indexPath = indexPath
//        }

        if segue.identifier == "AddNewItem" {
            // segue to Add item
        }
        else if segue.identifier == "EditItem" {
            // segue to Edit Item, pass in item & index
            let indexPath = sender as! NSIndexPath
            let itemString = items[indexPath.row]
            addItemTableController.itemString = itemString.text
            addItemTableController.indexPath = indexPath
        }
    }

    func fetchAllItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        do {    // fetch all items from db, place in items[] array
            let result = try managedObjectContext.fetch(request)
            items = result as! [BucketListItem]
        } catch {
            print("\(error)")
        }
    }

    // Cancel button pressed
    func cancelButtonPressed(by controller: AddItemTableViewController) {
//        print("Cancel")
        dismiss(animated: true, completion: nil)
    }

    // Save button pressed
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?) {
        if let ip = indexPath { // this item was edited
            let item = items[ip.row]
            item.text = text
        }
        else {  // this is a new item
            // insert item into db
//            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
            let item = BucketListItem(context: managedObjectContext)
            item.text = text
            items.append(item)
        }
        do {    // and save the changes to db
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        tableView.reloadData()
//        print("Add item \(text)")
        dismiss(animated: true, completion: nil)
    }
}
