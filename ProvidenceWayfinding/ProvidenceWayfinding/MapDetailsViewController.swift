//
//  MapDetailsViewController.swift
//  ProvidenceWayfinding
//
//  Created by Taras Kravchuk on 2/15/16.
//  Copyright © 2016 GU. All rights reserved.
//

import UIKit

class MapDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var mapType: Int!
    var turnbyturnStepDistance: [String] = []
    var turnbyturnStepIns: [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapStyle: UISegmentedControl!
    
    @IBAction func changeMapType(sender: AnyObject) {
        let navController = self.navigationController!
        let indexOfLastViewController = navController.viewControllers.count - 1
        let indexOfMap = indexOfLastViewController - 1
        let directionsViewController = navController.viewControllers[indexOfMap] as! DirectionsViewController
        self.mapType = mapStyle.selectedSegmentIndex
        directionsViewController.mapType = mapStyle.selectedSegmentIndex

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.layer.borderWidth = 0.5
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 40.0
        setMapType()
    }
    
    override func viewDidAppear(animated: Bool) {
        if(resetToRootView == 1){
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    func setMapType(){
        if mapType == nil {
            mapStyle.selectedSegmentIndex = 0
        }else{
            mapStyle.selectedSegmentIndex = mapType
        }

    }

    
    //MARK -- Table View section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return turnbyturnStepIns.count
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:BasicDirectionsCell = tableView.dequeueReusableCellWithIdentifier("BasicDirectionsCell", forIndexPath: indexPath) as! BasicDirectionsCell
        cell.subtitleLabel.text = self.turnbyturnStepIns[indexPath.row]
        cell.titleLabel.text = self.turnbyturnStepDistance[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
