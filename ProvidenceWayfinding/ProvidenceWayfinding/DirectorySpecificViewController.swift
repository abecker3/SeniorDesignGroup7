//
//  DirectorySpecificViewController.swift
//  ProvidenceWayfinding
//
//  Created by Ruth Manthey on 1/26/16.
//  Copyright © 2016 GU. All rights reserved.
//

import UIKit

class DirectorySpecificViewController: UIViewController {
    @IBOutlet weak var floorMap: UIImageView!
    @IBOutlet weak var scrollMap: UIScrollView!
    @IBOutlet weak var directorySpecificTitle: UINavigationItem!

    var passInName: String!
    var phoneExt: Int!
    var hours: String!
    var building: String!
    var floor: String!
    var thisFloor = String()
    var fileExtension = String()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var floorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: "doubleTapped")
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
        
        nameLabel.text = passInName
        getInfoFromName(directory)
        directorySpecificTitle.title = passInName
        phoneLabel.text = String(phoneExt)
        hoursLabel.text = hours
        buildingLabel.text = building
        floorLabel.text = floor
        //phoneLabel.text =
        fileExtension = ".jpg"
        
        setMap()
    }
    
    func setMap(){
        switch building{
        case "Children's Hospital": thisFloor = "Childrens_" + floor + fileExtension
        case "Main Tower": thisFloor = "Main_" + floor + fileExtension
        case "Women's Health Center": thisFloor = "Womens_" + floor + fileExtension
        case "Heart Institute": thisFloor = "Heart_" + floor + fileExtension
        default: "NotAvailable.jpg"
        }
        
        floorMap.image = UIImage(named: thisFloor)
        floorMap.contentMode = UIViewContentMode.ScaleAspectFit
        
        self.scrollMap.maximumZoomScale = 5.0
        self.scrollMap.clipsToBounds = true
    }
    
    func getInfoFromName(inputArray: [Directory]!) -> [String]!
    {
        var newArray = [String]()
        for x in inputArray
        {
            if(x.name == passInName)
            {
                newArray.append(x.name)
                phoneExt = x.ext
                hours = x.hours
                building = x.category
                floor = x.floor
            }
        }
        return newArray
    }

    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.floorMap
    }
    
    func doubleTapped() {
        if (scrollMap.zoomScale > 1){
            scrollMap.setZoomScale(0.25, animated: true)
        }
        else{
            scrollMap.setZoomScale(2, animated: true)
        }
    }
}
