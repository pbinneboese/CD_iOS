//
//  PeopleClass.swift
//  Star Wars Encyclopedia
//
//  Created by Paul Binneboese on 3/20/17.
//  Copyright © 2017 Paul Binneboese. All rights reserved.
//

import UIKit

struct PeopleAttributes {
    var name: String?
    var height: String?
    var mass: String?
    var hair_color: String?
    var birth_year: String?
    var homeworld: String?
    var films: [String]?
    var vehicles: [String]?
    var starships: [String]?
    init() {
        self.name = ""
        self.height = ""
        self.mass = ""
        self.hair_color = ""
        self.birth_year = ""
        self.homeworld = ""
        self.films = []
        self.vehicles = []
        self.starships = []
    }
}
