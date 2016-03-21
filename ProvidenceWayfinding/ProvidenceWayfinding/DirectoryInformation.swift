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
    Directory(name: "Adolescent Medicine", category: "Children's Hospital", floor: "L1 East", hours: "9AM to 5PM", ext: 45445),
    Directory(name: "Adult Geriatric Psychiatry Unit East", category: "Children's Hospital", floor: "Main", hours: "9AM to 5PM", ext: 44784),
    Directory(name: "Adult Geriatric Psychiatry Unit West", category: "Children's Hospital", floor: "Main", hours: "9AM to 5PM", ext: 44863),
    Directory(name: "Antepartum", category: "Women's Health Center", floor: "2 West", hours: "9AM to 5PM", ext: 46470),
    Directory(name: "BEST", category: "Children's Hospital", floor: "2", hours: "9AM to 5PM", ext: 0),
    Directory(name: "Birth Certificates", category: "Women's Health Center", floor: "Main", hours: "9AM to 5PM", ext: 44909),
    Directory(name: "Birth Place", category: "Women's Health Center", floor: "2", hours: "9AM to 5PM", ext: 46400),
    Directory(name: "Cafeteria", category: "Main Tower", floor: "L3", hours: "9AM to 5PM", ext: 0),
    Directory(name: "Cardiac (6N)", category: "Main Tower", floor: "6", hours: "9AM to 5PM", ext: 44852),
    Directory(name: "Cardiac (6S)", category: "Main Tower", floor: "6", hours: "9AM to 5PM", ext: 44850),
    Directory(name: "Cardiac (8N)", category: "Main Tower", floor: "6", hours: "9AM to 5PM", ext: 44660),
    Directory(name: "Cardiac (9N)", category: "Main Tower", floor: "6", hours: "9AM to 5PM", ext: 45400),
    Directory(name: "Cardiac Intensive Care Unit", category: "Main Tower", floor: "2", hours: "9AM to 5PM", ext: 44610),
    Directory(name: "Careshop", category: "Women's Health Center", floor: "Main West", hours: "9AM to 5PM Monday-Friday, 11AM to 3PM Saturday", ext: 44040),
    Directory(name: "Center of Gynecology/Robotics/Minimally Invasive Surgery", category: "Women's Health Center", floor: "Main West", hours: "9AM to 5PM", ext: 47370),
    Directory(name: "Child Life Specialists/Family Support Services", category: "Children's Hospital", floor: "4 East", hours: "9AM to 5PM", ext: 43049),
    Directory(name: "Children's Hospital Administration", category: "Children's Hospital", floor: "4 East", hours: "9AM to 5PM", ext: 42800),
    Directory(name: "Developmental Pediatrics", category: "Children's Hospital", floor: "4 East", hours: "9AM to 5PM", ext: 42730),
    Directory(name: "Doctors Building Information", category: "Doctors Building", floor: "Main", hours: "9AM to 5PM", ext: 44775),
    Directory(name: "Emergency Department", category: "Emergency Building", floor: "L1", hours: "12AM to 12AM", ext: 43344),
    Directory(name: "Gift Shop", category: "Main Tower", floor: "Main", hours: "9AM to 5PM", ext: 43285),
    Directory(name: "ICU Information", category: "Main Tower", floor: "2", hours: "9AM to 5PM", ext: 43310),
    Directory(name: "Labor & Delivery", category: "Women's Health Center", floor: "2", hours: "9AM to 5PM", ext: 46460),
    Directory(name: "Madison Inn", category: "Madison Inn", floor: "n/a", hours: "9AM to 5PM", ext: 4744200),
    Directory(name: "Main Entrance Information", category: "Main Tower", floor: "Main", hours: "9AM to 5PM", ext: 43227),
    Directory(name: "Main Floor Back Entrance Information", category: "Main Tower", floor: "Unknown", hours: "9AM to 5PM", ext: 43226),
    Directory(name: "Maternal-Fetal Medicine", category: "Women's Health Center", floor: "Main", hours: "9AM to 5PM", ext: 44060),
    Directory(name: "Maternity Clinic", category: "Women's Health Center", floor: "Main", hours: "8:30AM to 5PM Monday-Thursday, 8:30AM to 12:30PM Friday", ext: 43170),
    Directory(name: "Mother-Baby Place", category: "Women's Health Center", floor: "2 East", hours: "9AM to 5PM", ext: 42400),
    Directory(name: "Neonatal Intensive Care Unit", category: "Women's Health Center", floor: "3", hours: "9AM to 5PM", ext: 46300),
    Directory(name: "Neurology", category: "Main Tower", floor: "8", hours: "9AM to 5PM, closed weekends", ext: 44644),
    Directory(name: "Northwest Heart and Lung", category: "Providence Spokane Heart Institute", floor: "Main", hours: "9AM to 5PM", ext: 4560262),
    Directory(name: "Oncology", category: "Main Tower", floor: "7", hours: "9AM to 5PM", ext: 44940),
    Directory(name: "Ortho/Bone and Joint", category: "Main Tower", floor: "4", hours: "9AM to 5PM", ext: 44684),
    Directory(name: "PCCA", category: "Children's Hospital", floor: "2", hours: "9AM to 5PM", ext: 43213),
    Directory(name: "Pediatrics", category: "Children's Hospital", floor: "3 Main", hours: "9AM to 5PM", ext: 0),
    Directory(name: "Pediatric Emergency", category: "Emergency Building", floor: "L1", hours: "12AM to 12AM", ext: 45690),
    Directory(name: "Pediatric Endocrinology", category: "Children's Hospital", floor: "L1", hours: "9AM to 5PM", ext: 42880),
    Directory(name: "Pediatric Gastroenterology", category: "Doctors Building", floor: "Main", hours: "8AM to 5PM, closed weekends", ext: 45437),
    Directory(name: "Pediatric Intensive Care Unit", category: "Main Tower", floor: "3", hours: "9AM to 5PM", ext: 45233),
    Directory(name: "Pediatric Nephrology", category: "Doctors Building", floor: "Main", hours: "9AM to 5PM", ext: 3400930),
    Directory(name: "Pediatric Neurology", category: "Children's Hospital", floor: "4 East", hours: "8AM to 5PM, closed weekends", ext: 45440),
    Directory(name: "Pediatric Oncology Inpatient", category: "Children's Hospital", floor: "3 East", hours: "9AM to 5PM", ext: 42700),
    Directory(name: "Pediatric Oncology Outpatient", category: "Children's Hospital", floor: "3 East", hours: "9AM to 5PM", ext: 42777),
    Directory(name: "Pediatric Pulmonology", category: "Doctors Building", floor: "4", hours: "9AM to 5PM", ext: 46960),
    Directory(name: "Pediatric Surgeons", category: "Children's Hospital", floor: "L1", hours: "9AM to 5PM", ext: 45445),
    Directory(name: "Pediatric Surgery Center", category: "Main Tower", floor: "L1", hours: "9AM to 5PM", ext: 43112),
    Directory(name: "Postpartum", category: "Women's Health Center", floor: "2", hours: "9AM to 5PM", ext: 46480),
    Directory(name: "Providence Center for Congenital Heart Disease", category: "Children's Hospital", floor: "4 East", hours: "9AM to 5PM", ext: 46707),
    Directory(name: "Providence Center for Faith and Healing", category: "Faith and Healing", floor: "Main", hours: "9AM to 5PM", ext: 43008),
    Directory(name: "Spokane Cardiology", category: "Heart Institute", floor: "3", hours: "9AM to 5PM", ext: 4558820),
    Directory(name: "Surgery", category: "Surgery Center", floor: "Main", hours: "9AM to 5PM", ext: 44686),
    Directory(name: "Thomas Hammer Coffee (Cafeteria)", category: "Main Tower", floor: "L3", hours: "9AM to 5PM", ext: 44809),
    Directory(name: "Thomas Hammer Coffee (Emergency)", category: "Emergency Building", floor: "L1", hours: "9AM to 5PM", ext: 45839),
    Directory(name: "Thomas Hammer Coffee (Women's Building)", category: "Women's Health Center", floor: "Main", hours: "9AM to 5PM", ext: 43999),
    Directory(name: "Transplant", category: "Doctors Building", floor: "Main", hours: "9AM to 5PM", ext: 0),
    Directory(name: "Women's Health Center", category: "Women's Health Center", floor: "L2", hours: "9AM to 5PM", ext: 42400),
]