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
    var notes: String //any additional notes about each location, especially about entering restricted areas
}


/*let directory = [
    Directory(name: "Adolescent Medicine", category: "Children's Hospital", floor: "L1 East", hours: "8AM to 5PM Mon-Fri", ext: 45445, notes: ""),
    Directory(name: "Adult/Geriatric Psychiatry Unit East", category: "Children's Hospital", floor: "Main", hours: "", ext: 44784, notes: "Use phone to call reception"),
    Directory(name: "Adult/Geriatric Psychiatry Unit West", category: "Children's Hospital", floor: "Main", hours: "", ext: 44863, notes: "Use phone to call reception"),
    Directory(name: "Antepartum", category: "Women's Health Center", floor: "2 West", hours: "24-hour service", ext: 46470, notes: ""),
    Directory(name: "BEST", category: "Children's Hospital", floor: "2", hours: "8:30AM to 4:30PM Mon-Fri", ext: 0, notes: ""),
    Directory(name: "Birth Place", category: "Women's Health Center", floor: "2", hours: "24-hour service", ext: 46400, notes: ""),
    Directory(name: "Cafeteria", category: "Main Tower", floor: "L3", hours: "6:30AM to 7PM", ext: 0, notes: ""),
    Directory(name: "CARA", category: "Heart Institute", floor: "5", hours: "", ext: 0, notes: ""),
    Directory(name: "Cardiac (6N)", category: "Main Tower", floor: "6", hours: "", ext: 44852, notes: ""),
    Directory(name: "Cardiac (6S)", category: "Main Tower", floor: "6", hours: "", ext: 44850, notes: ""),
    Directory(name: "Cardiac (8N)", category: "Main Tower", floor: "6", hours: "", ext: 44660, notes: ""),
    Directory(name: "Cardiac (9N)", category: "Main Tower", floor: "6", hours: "", ext: 45400, notes: ""),
    Directory(name: "Cardiac Intensive Care Unit", category: "Main Tower", floor: "2", hours: "", ext: 44610, notes: ""),
    Directory(name: "Careshop", category: "Women's Health Center", floor: "Main West", hours: "9AM to 5PM Mon-Fri, 11AM to 3PM Sat", ext: 44040, notes: ""),
    Directory(name: "Center of Gynecology/Robotics/Minimally Invasive Surgery", category: "Women's Health Center", floor: "Main West", hours: "8AM - 5PM Mon-Fri", ext: 47370, notes: ""),
    Directory(name: "Child Life Specialists/Family Support Services", category: "Children's Hospital", floor: "4 East", hours: "", ext: 43049, notes: ""),
    Directory(name: "Children's Hospital Administration", category: "Children's Hospital", floor: "4 East", hours: "", ext: 42800, notes: ""),
    Directory(name: "Developmental Pediatrics", category: "Children's Hospital", floor: "4 East", hours: "8AM to 5PM Mon-Fri", ext: 42730, notes: ""),
    Directory(name: "Doctors Building Information", category: "Doctors Building", floor: "Main", hours: "9AM to 5PM", ext: 44775, notes: ""),
    Directory(name: "Emergency Department", category: "Main Tower", floor: "L1", hours: "24-hour service", ext: 43344, notes: ""),
    Directory(name: "Gift Shop", category: "Main Tower", floor: "Main", hours: "9:30AM to 5:30PM Mon-Thurs, 7AM to7:30PM Fri, 10:30AM to 5PM Sat-Sun", ext: 43285, notes: ""),
    Directory(name: "ICU Information", category: "Main Tower", floor: "2", hours: "", ext: 43310, notes: "No visitors under 18"),
    Directory(name: "Labor & Delivery", category: "Women's Health Center", floor: "2", hours: "24-hour service", ext: 46460, notes: ""),
    Directory(name: "Main Entrance Information", category: "Main Tower", floor: "Main", hours: "", ext: 43227, notes: ""),
    Directory(name: "Main Floor Back Entrance Information", category: "Main Tower", floor: "1", hours: "", ext: 43226, notes: ""),
    Directory(name: "Maternal-Fetal Medicine", category: "Women's Health Center", floor: "Main", hours: "8AM to 8PM Mon-Fri, 9AM to 6PM Sat-Sun", ext: 44060, notes: ""),
    Directory(name: "Maternity Clinic", category: "Women's Health Center", floor: "Main", hours: "8:30AM to 5PM Mon-Thurs, 8:30AM to 12:30PM Fri", ext: 43170, notes: ""),
    Directory(name: "Mother-Baby Unit", category: "Women's Health Center", floor: "2 East", hours: "6AM to 10PM", ext: 42400, notes: ""),
    Directory(name: "Neonatal Intensive Care Unit", category: "Women's Health Center", floor: "3", hours: "24-hour service", ext: 46300, notes: "No visitors under 18"),
    Directory(name: "Neurology", category: "Main Tower", floor: "8", hours: "8AM to 5PM Mon-Fri", ext: 44644, notes: ""),
    Directory(name: "Northwest Heart and Lung", category: "Heart Institute", floor: "Main", hours: "8:30AM to 5PM Mon-Fri", ext: 4560262, notes: ""),
    Directory(name: "Oncology", category: "Main Tower", floor: "7", hours: "", ext: 44940, notes: ""),
    Directory(name: "Ortho/Bone and Joint", category: "Main Tower", floor: "4", hours: "9AM to 5PM", ext: 44684, notes: ""),
    Directory(name: "PCCA", category: "Children's Hospital", floor: "2", hours: "", ext: 43213, notes: ""),
    Directory(name: "Pediatrics", category: "Main Tower", floor: "3", hours: "", ext: 0, notes: ""),
    Directory(name: "Pediatric Emergency", category: "Main Tower", floor: "L1", hours: "24-hour service", ext: 45690, notes: ""),
    Directory(name: "Pediatric Endocrinology", category: "Children's Hospital", floor: "L1", hours: "8AM to 5PM Mon-Fri", ext: 42880, notes: ""),
    Directory(name: "Pediatric Gastroenterology", category: "Doctors Building", floor: "Main", hours: "8AM to 5PM Mon-Fri", ext: 45437, notes: ""),
    Directory(name: "Pediatric Intensive Care Unit", category: "Main Tower", floor: "3", hours: "24-hour service", ext: 45233, notes: "Use camera and button to check in"),
    Directory(name: "Pediatric Nephrology", category: "Doctors Building", floor: "Main", hours: "8AM to 5PM Mon-Fri", ext: 3400930, notes: ""),
    Directory(name: "Pediatric Neurology", category: "Children's Hospital", floor: "4 East", hours: "8AM to 5PM Mon-Fri", ext: 45440, notes: ""),
    Directory(name: "Pediatric Oncology Inpatient", category: "Children's Hospital", floor: "3 East", hours: "", ext: 42700, notes: ""),
    Directory(name: "Pediatric Oncology Outpatient", category: "Children's Hospital", floor: "3 East", hours: "8AM to 5PM Mon-Fri", ext: 42777, notes: ""),
    Directory(name: "Pediatric Pulmonology", category: "Doctors Building", floor: "4", hours: "8AM to 5PM Mon-Fri", ext: 46960, notes: ""),
    Directory(name: "Pediatric Surgeons", category: "Children's Hospital", floor: "L1", hours: "", ext: 45445, notes: ""),
    Directory(name: "Pediatric Surgery Center", category: "Main Tower", floor: "L1", hours: "8AM to 5PM Mon-Fri", ext: 43112, notes: ""),
    Directory(name: "Postpartum", category: "Women's Health Center", floor: "2", hours: "24-hour service", ext: 46480, notes: ""),
    Directory(name: "Pre-admission Clinic", category: "Women's Health Center", floor: "Main", hours: "8AM to 5PM Mon-Fri", ext: 0, notes: ""),
    Directory(name: "Providence Center for Congenital Heart Disease", category: "Children's Hospital", floor: "4 East", hours: "8AM to 5PM Mon-Fri", ext: 46707, notes: ""),
    Directory(name: "Providence Center for Faith and Healing", category: "Faith and Healing", floor: "Main", hours: "", ext: 43008, notes: ""),
    Directory(name: "Spokane Cardiology", category: "Heart Institute", floor: "4", hours: "8:30AM to 5PM Mon-Fri", ext: 4558820, notes: ""),
    Directory(name: "Surgery", category: "Women's Health Center", floor: "Main", hours: "", ext: 44686, notes: ""),
    Directory(name: "Thomas Hammer Coffee (Cafeteria)", category: "Main Tower", floor: "L3", hours: "", ext: 44809, notes: ""),
    Directory(name: "Thomas Hammer Coffee (Emergency)", category: "Main Tower", floor: "L1", hours: "", ext: 45839, notes: ""),
    Directory(name: "Thomas Hammer Coffee (Women's Building)", category: "Women's Health Center", floor: "Main", hours: "", ext: 43999, notes: ""),
    Directory(name: "Transplant", category: "Doctors Building", floor: "Main", hours: "8AM to 5PM Mon-Fri", ext: 0, notes: ""),
    Directory(name: "Valet Parking", category: "Women's Health Center", floor: "L2", hours: "24-hour service", ext: 0, notes: ""),
    Directory(name: "Women's Health Center", category: "Women's Health Center", floor: "L2", hours: "", ext: 42400, notes: ""),
]*/

var directory = [Directory]();

func loadDirectory()
{
    let fileVertices = NSBundle.mainBundle().pathForResource("data/vertices", ofType: "csv")!
    
    let error: NSErrorPointer = nil
    
    let tableVertices = CSV(contentsOfFile: fileVertices, error: error);
    
    //Vertices
    for row in tableVertices!.rows
    {
        let id = row["ID"]!;
        let name = row["Name"]!;
        let x = row["X"]!;
        let y = row["Y"]!;
        let building = row["Building"]!;
        let floor = row["Floor"]!;
        let category = row["Category"]!;
        let hours = row["Hours"]!;
        let ext = row["Ext"]!;
        let notes = row["Notes"]!;

        if(category != "")
        {
            directory.append(Directory(name: String(name), category: String(category), floor: String(floor), hours: String(hours), ext: Int(ext)!, notes: String(notes)))
        }
    }
    loadAdditional();
}

func loadAdditional()
{
    directory.append(Directory(name: "Doctors Building Information", category: "Doctors Building", floor: "Main", hours: "9AM to 5PM", ext: 44775, notes: ""))
    directory.append(Directory(name: "Pediatric Gastroenterology", category: "Doctors Building", floor: "Main", hours: "8AM to 5PM Mon-Fri", ext: 45437, notes: ""))
    directory.append(Directory(name: "Pediatric Nephrology", category: "Doctors Building", floor: "Main", hours: "8AM to 5PM Mon-Fri", ext: 3400930, notes: ""))
    directory.append(Directory(name: "Pediatric Pulmonology", category: "Doctors Building", floor: "4", hours: "8AM to 5PM Mon-Fri", ext: 46960, notes: ""))
    directory.append(Directory(name: "Transplant", category: "Doctors Building", floor: "Main", hours: "8AM to 5PM Mon-Fri", ext: 0, notes: ""))
}




var directoryEntry = Directory(name: "NA", category: "NA", floor: "NA", hours: "NA", ext: 0, notes: "")
var parkingEntry = Directory(name: "NA", category: "NA", floor: "NA", hours: "NA", ext: 0, notes: "")
var parkingHistEntry = Directory(name: "NA", category: "NA", floor: "NA", hours: "NA", ext: 0, notes: "")
var routeFromWhichScreen = 0
var flagForPlace = 0
var resetToRootView = 0