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
    Concession(name: "Cafe Cafeteria", category: "Main Tower", floor:"L3", hours:"6:30 AM to 7 PM"),
    Concession(name: "Cafe Cafeteria2", category: "Main Tower", floor: "L3", hours: "6:30 AM to 7 PM"),
    Concession(name: "Test", category: "Children's Hospital", floor: "L3", hours: "6:30 AM to 7 PM"),
    Concession(name: "Test1", category: "Doctor's Building", floor: "3", hours: "8 AM to 6 PM"),
    Concession(name: "Test2", category: "Heart Institute", floor: "L2", hours: "9 AM to 6 PM")
]