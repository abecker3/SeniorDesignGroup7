//
//  Concessions.swift
//  ProvidenceWayfinding
//
//  Created by McBurney, Shaun W on 12/2/15.
//  Copyright © 2015 GU. All rights reserved.
//

import Foundation

struct Concession
{
    var name: String
    var category: String
    var floor: String
    var hours: String
}

let concessions = [
    Concession(name: "Cafe Cafeteria",                  category: "Main Tower",             floor:"L3",     hours:"6:30 AM to 7 PM"),
    Concession(name: "Thomas Hammer (Cafeteria)",       category: "Main Tower",             floor: "L3",    hours: "6:30 AM to 7 PM"),
    Concession(name: "Thomas Hammer (Emergency)",       category: "Emergency",              floor: "1",     hours: "6:30 AM to 7 PM"),
    Concession(name: "Thomas Hammer (Women's Center)",  category: "Women's Health Center",  floor: "Main",  hours: "6:30 AM to 7 PM"),
]