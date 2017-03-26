//
//  TableViewController.swift
//  ToDoList
//
//  Created by Paul Binneboese on 3/16/17.
//  Copyright © 2017 Paul Binneboese. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

//    let Subjects = ["Eat Lunch", "Study iOS", "Sleep a bit", "Celebrate after Belt Exam"]
//    let Descriptions = ["Go to Broiler Bay at noon", "Starting a Hackathon on AV Foundation", "At least 6 hours, hopefully 7 1/2", "Take family out to Buca di Beppo"]
//    let Dates = ["3/17/2017", "3/20/2017", "Today", "3/24/2017"]

    var ToDoList = [ToDoItem]()

    
    // open access to db context
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems() // load ToDoList from database

//        or load ToDoList from static table
//        var item = ToDoItem()
//        for i in 0..<Subjects.count {   // initialize ToDoList list
//            item.subject = Subjects[i]
//            item.descr = Descriptions[i]
//            item.date = Dates[i]
//            ToDoList.append(item)
//            }
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // segue to ToDo Item View
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddNewItem") {
            let ToDoItemController = segue.destination as! ItemViewController
            ToDoItemController.delegate = self
        }
    }
    
    // count number of ToDo items
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoList.count
    }
    
    // return an item <indexPath>
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeue cell from storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        // update cells' text from item list
        cell.SubjectLabel.text = ToDoList[indexPath.row].subject
        cell.DescriptionLabel.text = ToDoList[indexPath.row].descr
        cell.DateLabel.text = ToDoList[indexPath.row].date
        cell.accessoryType = (ToDoList[indexPath.row].done ? .checkmark : .none)
        return cell
    }
    
    // select row, show Checkmark (accessory)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if ToDoList[indexPath.row].done == false {  // mark if not already marked
                ToDoList[indexPath.row].done = true
                cell.accessoryType = .checkmark
                tableView.reloadData()
                do {    // and save to db
                    try managedObjectContext.save()
                } catch {
                    print("\(error)")
                }
            }
        }
    }

    // press Delete (swipe)
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {    // remove item from db
        let thisItem = ToDoList[indexPath.row]
        managedObjectContext.delete(thisItem)
        do {    // update db with changes
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        ToDoList.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    // Save Item button pressed (from Add Item view)
    func itemSaved(by controller: ItemViewController) {
        print("Add item \(controller.itemSubject)")
        let newItem = ToDoItem(context: managedObjectContext)
        newItem.subject = controller.itemSubject
        newItem.descr = controller.itemDescription
        newItem.date = controller.itemDate
        newItem.done = false
        ToDoList.append(newItem)
        self.tableView.reloadData()
        do {    // save the item into db
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
    }
    
    // get ToDoList from database
    func fetchAllItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoItem")
        do {    // fetch all items from db, place in ToDoList[] array
            let result = try managedObjectContext.fetch(request)
            ToDoList = result as! [ToDoItem]
        } catch {
            print("\(error)")
        }
    }
    
}

