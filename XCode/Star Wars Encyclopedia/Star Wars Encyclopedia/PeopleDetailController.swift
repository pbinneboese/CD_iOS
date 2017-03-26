//
//  PeopleDetailController.swift
//  Star Wars Encyclopedia
//
//  Created by Paul Binneboese on 3/20/17.
//  Copyright © 2017 Paul Binneboese. All rights reserved.
//

import UIKit

class PeopleDetailController: UIViewController {
    
    var delegate: PeopleViewController?
    var person: PeopleAttributes!
    
    
    @IBOutlet var peopleDetail: [UILabel]!
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // show the person's stats
        peopleDetail[0].text = person.name
        peopleDetail[2].text = person.height
        peopleDetail[3].text = person.mass
        peopleDetail[5].text = person.hair_color
        peopleDetail[4].text = person.birth_year
//        peopleDetail[1].text = person.homeworld
//        for i in 0..<person.films!.count {
//            peopleDetail[6].text!.append(person.films![i])
//        }
//        for i in 0..<person.vehicles!.count {
//            peopleDetail[7].text = person.vehicles![i]
//        }
//        for i in 0..<person.starships!.count {
//            peopleDetail[8].text = person.starships![i]
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
