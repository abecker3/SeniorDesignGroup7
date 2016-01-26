//
//  OnCampusViewController.swift
//  ProvidenceWayfinding
//
//  Created by Becker, Andrew D on 11/3/15.
//  Copyright © 2015 GU. All rights reserved.
//


import UIKit

class OnCampusViewController: UIViewController, UIScrollViewDelegate{
    @IBOutlet weak var scrollCurrent: UIScrollView!
    @IBOutlet weak var currentMap: UIImageView!
    var startLocation: Location!
    var endLocation: Location!
    
    var destinationFloor = String()
    var currentFloor = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        switch startLocation.category{
        case "Children's Hospital": currentFloor = getFloorChildrens(startLocation)
        case "Women's Health Center": currentFloor = getFloorWomens(startLocation)
        case "Heart Institute": currentFloor = getFloorHeart(startLocation)
        case "Main Tower": currentFloor = getFloorMain(startLocation)
        case "Emergency": currentFloor = getFloorMain(startLocation)
        case "Surgery Center": currentFloor = getFloorWomens(startLocation)
        default: currentFloor = "NotAvailable.jpg"
        }
        
        switch endLocation.category{
        case "Children's Hospital": destinationFloor = getFloorChildrens(endLocation)
        case "Women's Health Center": destinationFloor = getFloorWomens(endLocation)
        case "Heart Institute": destinationFloor = getFloorHeart(endLocation)
        case "Main Tower": destinationFloor = getFloorMain(endLocation)
        case "Emergency": destinationFloor = getFloorMain(endLocation)
        case "Surgery Center": destinationFloor = getFloorWomens(endLocation)
        default: destinationFloor = "NotAvailable.jpg"
        }
        
        
        currentMap.image = UIImage(named: currentFloor)
        currentMap.contentMode = UIViewContentMode.ScaleAspectFit

        self.scrollCurrent.maximumZoomScale = 5.0
        self.scrollCurrent.clipsToBounds = true
                
        //let nextViewController = UIStoryboardSegue.destinationViewController as! DestinationViewController;
        //nextViewController.destinationFloor = self.destinationFloor
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nextViewController = segue.destinationViewController as! DestinationViewController;
        nextViewController.destinationFloor = self.destinationFloor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
            return self.currentMap
        
    }
    
    func getFloorChildrens(floorMap: Location) -> String{
        switch floorMap.floor{
        //case "2": return "Childrens_2.jpg"
        //case "3": return "Childrens_3.jpg"
        //case "4": return "Childrens_4.jpg"
        //case "5": return "Childrens_5.jpg"
        //default: return "Childrens_1.jpg"
        default: return "NotAvailable.jpg"
        }
    }
    
    func getFloorHeart(floorMap: Location) -> String{
        switch floorMap.floor{
        //case "2": return "Heart_2.jpg"
        //case "3": return "Heart_3.jpg"
        //case "4": return "Heart_4.jpg"
        //case "5": return "Heart_5.jpg"
        //default: return "Heart_1.jpg"
        default: return "Heart_2.jpg"
        }
    }
    
    func getFloorMain(floorMap: Location) -> String{
        switch floorMap.floor{
        //case "2": return "Main_2.jpg"
        //case "3": return "Main_3.jpg"
        //case "4": return "Main_4.jpg"
        //case "5": return "Main_5.jpg"
        //default: return "Main_1.jpg"
        default: return "Heart_1.jpg"
        }
    }
    
    func getFloorWomens(floorMap: Location) -> String{
        switch floorMap.floor{
       // case "2": return "Womens_2.jpg"
        //case "3": return "Womens_3.jpg"
        //case "4": return "Womens_4.jpg"
        //case "5": return "Womens_5.jpg"
        //default: return "Womens_1.jpg"
        default: return "NotAvailable.jpg"
        }
    }
    
}