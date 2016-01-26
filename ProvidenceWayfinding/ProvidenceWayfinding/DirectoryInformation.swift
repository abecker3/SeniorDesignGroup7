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
    var ext: Int //phone extension, named ext because extension is a keyword
}


let directory = [
    Directory(name: "Adolescent Medicine", category: "Children's Hospital", floor: "?", hours: "9AM to 5PM", ext: 45445),
    Directory(name: "Child Life Specialists", category: "Children's Hospital", floor: "?", hours: "9AM to 5PM", ext: 43049),
    Directory(name: "Children's Hospital Administration", category: "Children's Hospital", floor: "?", hours: "9AM to 5PM", ext: 42800),
    Directory(name: "Developmental Pediatrics", category: "Children's Hospital", floor: "?", hours: "9AM to 5PM", ext: 42730),
    Directory(name: "Intermediate Nursing", category: "Children's Hospital", floor: "?", hours: "9AM to 5PM", ext: 44648),
    Directory(name: "Neonatal Intensive Care Unit", category: "Women's Health Center", floor: "3", hours: "9AM to 5PM", ext: 46300),
    Directory(name: "Pediatric Emergency", category: "Emergency", floor: "L1", hours: "9AM to 5PM", ext: 45690),
    Directory(name: "Pediatric Endocrinology", category: "Children's Hospital", floor: "?", hours: "9AM to 5PM", ext: 42880),
    Directory(name: "Pediatric Gastroenterology", category: "Children's Hospital", floor: "?", hours: "9AM to 5PM", ext: 45437),
    Directory(name: "Pediatric Intensive Care Unit", category: "Children's Hospital", floor: "?", hours: "9AM to 5PM", ext: 45233),
    Directory(name: "Pediatric Intensivists", category: "Children's Hospital", floor: "?", hours: "9AM to 5PM", ext: 45233),
    Directory(name: "Pediatric Nephrology", category: "Children's Hospital", floor: "?", hours: "9AM to 5PM", ext: 3400930),
    Directory(name: "Pediatric Neurology", category: "Children's Hospital", floor: "?", hours: "9AM to 5PM", ext: 45440),
    Directory(name: "Pediatric Oncology Inpatient", category: "Children's Hospital", floor: "3", hours: "9AM to 5PM", ext: 42700),
    Directory(name: "Pediatric Oncology Outpatient", category: "Children's Hospital", floor: "3", hours: "9AM to 5PM", ext: 42777),
    Directory(name: "Pediatric Pulmonology", category: "?", floor: "?", hours: "9AM to 5PM", ext: 46960),
    Directory(name: "Pediatric Surgeons", category: "?", floor: "?", hours: "9AM to 5PM", ext: 45445),
    Directory(name: "Pediatric Surgery Center", category: "?", floor: "?", hours: "9AM to 5PM", ext: 43112),
    Directory(name: "Providence Center for Congenital Heart Disease", category: "?", floor: "?", hours: "9AM to 5PM", ext: 46707),
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