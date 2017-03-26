//
//  PeopleViewController.swift
//  Star Wars Encyclopedia
//
//  Created by Paul Binneboese on 3/20/17.
//  Copyright © 2017 Paul Binneboese. All rights reserved.
//

import UIKit
class PeopleViewController: UITableViewController {
    
    var people = [PeopleAttributes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // specify the url that we will be sending the GET Request to
        let url = URL(string: "http://swapi.co/api/people/")
        // create a URLSession to handle the request tasks
        let session = URLSession.shared
        // create a "data task" to make the request and run the completion handler
        let task = session.dataTask(with: url!, completionHandler: {
            // see: Swift closure expression syntax
            data, response, error in
            // data -> JSON data, response -> headers and other meta-information, error-> if one occurred
            // "do-try-catch" blocks execute a try statement and then use the catch statement for errors
            do {
                // try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let results = jsonResult["results"] as? NSArray {
                        // coercing the results object as an NSArray and then storing that in resultsArray
                        var thisPerson = PeopleAttributes()
                        for i in 0..<results.count {   // build the list of people & attributes
                            let personDict = results[i] as! NSDictionary
//                            print(personDict)
                            thisPerson.name = personDict["name"] as? String
                            thisPerson.height = personDict["height"] as? String
                            thisPerson.mass = personDict["mass"] as? String
                            thisPerson.hair_color = personDict["hair_color"] as? String
                            thisPerson.birth_year = personDict["birth_year"] as? String
                            thisPerson.homeworld = personDict["homeworld"] as? String
                            thisPerson.films = personDict["films"] as? [String]
                            thisPerson.vehicles = personDict["vehicles"] as? [String]
                            thisPerson.starships = personDict["starships"] as? [String]
                            self.people.append(thisPerson)
                            print("New Person \(self.people[i].name!)")
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            } catch {
                print(error)
            }
        })
        // execute the task and wait for the response before
        // running the completion handler. This is async!
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // if we return - sections we won't have any sections to put our rows in
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the count of people in our data array
        return people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create/populate a cell with a person's data
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        cell.accessoryType = .detailButton
        cell.textLabel?.text = people[indexPath.row].name!
//        print(indexPath.row, people[indexPath.row].name!)
        return cell
    }

    // user selects a person's detail accessory
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowPerson", sender: indexPath)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowPerson") {
            let nextViewController = segue.destination as! PeopleDetailController
            nextViewController.delegate = self
            let indexPath = sender as! NSIndexPath
            nextViewController.person = people[indexPath.row]
        }
    }

}
