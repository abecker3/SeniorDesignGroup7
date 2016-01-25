//
//  DirectoryInformation.swift
//  ProvidenceWayfinding
//
//  Created by Ruth Manthey on 1/25/16.
//  Copyright © 2016 GU. All rights reserved.
//

import Foundation

struct Directory
{
    var name: String
    var category: String
    var floor: String
    var hours: String
    var ext: String //phone extension, named ext because extension is a keyword
}


let directory = [
    Directory(name: "Admitting", category: "Main Tower", floor: "Main", hours: "9AM to 5PM", ext: "12345"),
    /*Location(name: "Admitting",                                                         category: "Main Tower",                     floor: "Main"),
    Location(name: "Birth Place",                                                       category: "Women's Health Center",          floor: "2"),
    Location(name: "Bone & Joint Center",                                               category: "Main Tower",                     floor: "4"),
    Location(name: "Cafeteria",                                                         category: "Main Tower",                     floor: "L3"),
    Location(name: "Cardiac Admit Recovery Area (CARA)",                                category: "Heart Institute",                floor: "5"),
    Location(name: "Center for Gynecology, Robotics & Minimally Invasive Surgery",      category: "Women's Health Center",          floor: "Main"),
    Location(name: "Center for Maternal-Fetal Medicine",                                category: "Women's Health Center",          floor: "Main"),
    Location(name: "Chapel",                                                            category: "Main Tower",                     floor: "Main"),
    Location(name: "Day Surgery Center",                                                category: "Doctors Building",               floor: "5"),
    Location(name: "Emergency Department (Child & Adult)",                              category: "Emergency",                      floor: "L1"),
    Location(name: "Family Waiting Room (Surgery)",                                     category: "Surgery Center",                 floor: "Main"),
    Location(name: "Gift Shop",                                                         category: "Main Tower",                     floor: "Main"),
    Location(name: "L1 Family Waiting Room",                                            category: "Main Tower",                     floor: "L1"),
    Location(name: "Kidney Transplant Program",                                         category: "Doctors Building",               floor: "Main"),
    Location(name: "Maternity Clinic",                                                  category: "Women's Health Center",          floor: "Main"),
    Location(name: "Neonatal Intensive Care Unit (NICU)",                               category: "Women's Health Center",          floor: "3"),
    Location(name: "Oncology (Pediatric)",                                              category: "Children's Hospital",            floor: "3"),
    Location(name: "Oncology (Adult)",                                                  category: "Main Tower",                     floor: "7"),
    Location(name: "Pediatric Surgery Center",                                          category: "Main Tower",                     floor: "L1"),
    Location(name: "Pre-Admission Unit",                                                category: "Surgery Center",                 floor: "Main"),
    Location(name: "Providence Center for Faith & Healing",                             category: "Faith & Healing",                floor: "Main"),
    Location(name: "Providence Continence Center",                                      category: "Surgery Center",                 floor: "Main"),
    Location(name: "Providence Neuroscience Center",                                    category: "Doctors Building",               floor: "3"),
    Location(name: "Providence Spokane Heart Institute/Skywalk",                        category: "Main Tower",                     floor: "L3"),
    Location(name: "Providence Regional Cancer Center",                                 category: "Doctors Building",               floor: "Main"),
    Location(name: "Security",                                                          category: "Women's Health Center",          floor: "L3"),
    Location(name: "Skybridge Family Waiting Room",                                     category: "Main Tower",                     floor: "L1"),
    Location(name: "Surgery Admit Unit",                                                category: "Surgery Center",                 floor: "L1"),
    Location(name: "Surgery Entrance (8th & McClellan)",                                category: "Surgery Center",                 floor: "L2"),
    Location(name: "Surgery Family Waiting Room",                                       category: "Surgery Center",                 floor: "Main"),
    Location(name: "Surgery/Procedure Check-in",                                        category: "Surgery Center",                 floor: "Main"),
    Location(name: "The Careshop",                                                      category: "Women's Health Center",          floor: "Main"),
    Location(name: "Valet Parking (Emergency)",                                         category: "Emergency",                      floor: "L1"),
    Location(name: "Valet Parking (Main Tower)",                                        category: "Main Tower",                     floor: "Main"),
    Location(name: "Valet Parking (Surgery Center)",                                    category: "Surgery Center",                 floor: "L2"),
    Location(name: "Waiting Room (L1 Family)",                                          category: "Main Tower",                     floor: "L1"),
    Location(name: "Waiting Room (Intensive Care)",                                     category: "Main Tower",                     floor: "2"),
    Location(name: "Waiting Room (Pediatric Surgery/Family)",                           category: "Main Tower",                     floor: "L1"),
    Location(name: "Waiting Room (Skybridge)",                                          category: "Main Tower",                     floor: "L1"),
    Location(name: "Waiting Room (Surgery)",                                            category: "Surgery Center",                 floor: "Main"),*/
]