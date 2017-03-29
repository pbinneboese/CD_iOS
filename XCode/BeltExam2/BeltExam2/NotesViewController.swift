//
//  NotesViewController.swift
//  BeltExam2
//
//  Created by Paul Binneboese on 3/28/17.
//  Copyright © 2017 Paul Binneboese. All rights reserved.
//

import UIKit
import CoreData

class NotesViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {

    var searchController = UISearchController(searchResultsController: nil)

    var Notes = [Note]()    // list of all notes
    var filteredNotes: [Note]?
    
    //
    // View Controller Stuff
    //
    override func viewDidLoad() {
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        super.viewDidLoad()
        fetchItems()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.dismiss(animated: false, completion: nil)
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
        return (filteredNotes != nil) ? filteredNotes!.count : 0
//        return Notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        
        // show only filtered notes (in case Search is active)
        if let fnote = filteredNotes?[indexPath.row] {
            print("note \(fnote.text!)")
            cell.textLabel!.text = fnote.text
            let itemDate = fnote.updated_at
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            dateformatter.timeStyle = .none
            dateformatter.dateFormat = "MM-dd-yyyy"
            let itemDateString = dateformatter.string(from: itemDate as! Date)
            cell.detailTextLabel!.text = itemDateString
        }
        //        print("cell \(indexPath.row)")
        return cell
    }

    // Search Results Stuff
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {  // Search is active
            filteredNotes = Notes.filter { fnote in
                return fnote.text!.lowercased().contains(searchText.lowercased())
            }
        } else {    // Search is inactive
            filteredNotes = Notes
        }
        tableView.reloadData()
    }
    
    // Save button pressed
    func itemSaved(by controller: NotesEntryController, newItem: Bool) {
        if newItem {    // added new item
            let item = getNewItem()
            item.text = controller.textString
            item.updated_at = Date() as NSDate?
            print("Add item \(item.text)")
            addItemtoDB(item)
        }
        else {  // edited existing item
            print("Edit item \(controller.textString)")
            if let indexPath = controller.indexPath {
                let item = Notes[indexPath.row]
                item.text = controller.textString
                item.updated_at = Date() as NSDate?
                updateItemtoDB(item)
            }
        }
        fetchItems()
    }
    
    // press Delete (swipe)
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = Notes[indexPath.row]
        print("Delete item \(item.text)")
        deleteItemfromDB(item)
        fetchItems()
    }
    
    // Tap cell - edit contents
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItem", sender: indexPath)
    }
    
    // segue to NotesEntry View
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let NotesEntry = segue.destination as! NotesEntryController
        NotesEntry.delegate = self
        if segue.identifier == "AddNewItem" {   // creating a new item
            NotesEntry.textString = ""
            NotesEntry.indexPath = nil
            NotesEntry.newItem = true
        }
        else {  // editing an existing item
            let indexPath = sender as! NSIndexPath
            NotesEntry.textString = Notes[indexPath.row].text
            NotesEntry.indexPath = indexPath
            NotesEntry.newItem = false
        }
    }


    //
    // DATABASE FUNCTIONS
    //
    
    // open access to db context
    let dbContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func getNewItem() -> Note {
        let item = Note(context: dbContext)
        return item
    }
    
    func addItemtoDB(_ item: Note) {
        do {    // save the item into db
            try dbContext.save()
        } catch {
            print("DB \(error)")
        }
    }
    
    func updateItemtoDB(_ item: Note) {
        if dbContext.hasChanges {
            do {    // save the item into db
                try dbContext.save()
            } catch {
                print("DB \(error)")
            }
        }
    }
    
    func deleteItemfromDB(_ item: Note) {
        dbContext.delete(item)
        do {
            try dbContext.save()
        } catch {
            print("DB \(error)")
        }
    }
    
    
    func fetchItems() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        let sortDescriptor = NSSortDescriptor(key: "updated_at", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let result = try dbContext.fetch(fetchRequest)
            Notes = result as! [Note]
        } catch {
            print("DB \(error)")
        }
        updateSearchResults(for: searchController)
//        self.tableView.reloadData()
    }

}
