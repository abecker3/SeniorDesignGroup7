//
//  DirectionsViewController.swift
//  MapTest
//
//  Created by Taras Kravchuk on 10/7/15.
//  Copyright © 2015 Taras Kravchuk. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self * 3.28084 }
    var mi: Double { return self * 0.000621371192 }
}

class DirectionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, CLLocationManagerDelegate {

    var destination: MKMapItem?
    var desPlace: MKPlacemark!
    var annotation:MKAnnotation!
    var error:NSError!
    var pointAnnotation = MKPointAnnotation()
    
    var pinAnnotationView:MKPinAnnotationView!
    var locationManager: CLLocationManager?
    var endLocation: Location!
    var startLocation: Location!
    var counterForCurLocationButton = 0 //counter used in curLocationButton that changes map settings
    var hidden = false //flag used in hideView func
    var regionChangeIsFromUserInteraction = false //bool value for checking if user moved map
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var turnbyturnStepDistance: [String] = [""]
    var turnbyturnStepIns: [String] = [""]
    var timer = NSTimer()
    var updateDirectionsCheck: [String]!
    var updateDistanceCheck: [String]!
    
    // Parking Location Coordinates
    let DoctorBuilding = CLLocationCoordinate2D(
        latitude: 47.648183,
        longitude: -117.413864
    )
    let ChildrenHospital = CLLocationCoordinate2D(
        latitude: 47.649214,
        longitude: -117.411316
    )
    let HeartInst = CLLocationCoordinate2D(
        latitude: 47.650346,
        longitude: -117.412597
    )
    let WomensHealth = CLLocationCoordinate2D(
        latitude: 47.648815,
        longitude: -117.415504
    )
    let ER = CLLocationCoordinate2D(
        latitude: 47.648252,
        longitude: -117.411494
    )
    
    //TODO - Add anotation at destination parking spot
    //TODO - Add photo of parking garage entrance at destination pin
    //TODO - Maybe change textview steps to table view
    //TODO - Implement the tabls view with steps to change the region shown on map to that particular step
    
    //done -- TODO -- BUG - error message when choose dest. when off campus selected, then if you select to on, the dest portion doesnt reset but causes error if not rechosen. Also, if only the dest. is selected in the on campus mode, it will go to off campus wayfindgin map.
    //done -- TODO -- BUG - when location services are not allowed, app gets stuck on error screen. Need prompt to dismiss and take to pin of hospital as standard.
    
    //MARK - Outlets
    @IBOutlet weak var curLocationButton: UIButton! //button (bottom left) to change MKUserTrackingMode
    @IBOutlet var showMapView: MKMapView! //This is the mapView
   // @IBOutlet weak var DirectionsOutput: UITextView!
    
    //outlets for constraints used in hideView func
    @IBOutlet weak var DetailsButton: UIButton!
    @IBOutlet weak var viewBottomHeight: NSLayoutConstraint!
    @IBOutlet weak var dirOutBottomHeight: NSLayoutConstraint!
    //@IBOutlet weak var directionsOutputHeight: NSLayoutConstraint!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var tableView: UITableView!

    
    //MARK - Functions
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nextViewController = segue.destinationViewController as! ParkingPathViewController
        nextViewController.startLocation = self.startLocation
        nextViewController.endLocation = self.endLocation
    }
    override func viewWillAppear(animated: Bool) {
        statusCheck()
        self.tableView.reloadData()


    }

    override func viewWillDisappear(animated: Bool) {
        self.turnbyturnStepDistance.removeAll()
        self.turnbyturnStepDistance.append("")
        self.turnbyturnStepIns.removeAll()
        self.turnbyturnStepIns.append("")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.infoView.layer.borderWidth = 0.5
        self.tableView.layer.borderWidth = 0.5

        self.navigationController?.navigationBar.translucent = true //make top bar transluscent
        self.locationManager?.distanceFilter = kCLDistanceFilterNone
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        showMapView.showsUserLocation = true
        showMapView.mapType = .Standard
        showMapView.delegate = self
        curLocationButton.setImage(UIImage(named: "NearMe100.png"), forState: .Normal)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 90.0
        self.tableView.separatorStyle = .None
    }

    
    //MARK -- Table View section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    /*func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }*/
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:BasicDirectionsCell = tableView.dequeueReusableCellWithIdentifier("BasicDirectionsCell", forIndexPath: indexPath) as! BasicDirectionsCell
            cell.subtitleLabel.text = self.turnbyturnStepIns[indexPath.row]
            cell.titleLabel.text = self.turnbyturnStepDistance[indexPath.row]
            print("index = \(indexPath.row)")

        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    
    
    //Set desPlace based on the endLocation.category being passed through
    func setDestination(){
        switch endLocation.category{
            case "Heart Institute":
                desPlace = MKPlacemark(coordinate: HeartInst, addressDictionary: nil)
            case "Main Tower":
                desPlace = MKPlacemark(coordinate: DoctorBuilding, addressDictionary: nil)
            case "Women's Health Center":
                desPlace = MKPlacemark(coordinate: WomensHealth, addressDictionary: nil)
            case "Doctors Building":
                desPlace = MKPlacemark(coordinate: DoctorBuilding, addressDictionary: nil)
            case "Surgery Center":
                desPlace = MKPlacemark(coordinate: WomensHealth, addressDictionary: nil)
            case "Faith & Healing":
                desPlace = MKPlacemark(coordinate: DoctorBuilding, addressDictionary: nil)
            case "Children's Hospital":
                desPlace = MKPlacemark(coordinate: ChildrenHospital, addressDictionary: nil)
            default:
                desPlace = MKPlacemark(coordinate: DoctorBuilding, addressDictionary: nil)
        }
    }
    
    func scheduledTimerWithTimeInterval(){
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("updateDirections"), userInfo: nil, repeats: true)
    }
    
    func updateDirections(){
        let request = MKDirectionsRequest()
        request.source = MKMapItem.mapItemForCurrentLocation()
        request.destination = MKMapItem(placemark: desPlace)
        
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        directions.calculateDirectionsWithCompletionHandler{
            response, error in
            
            guard let response = response else {
                self.displayAlertWithTitle("Error",
                    message: "Error getting directions, please check your data connection and retry getting directions")
                return
            }
            self.showMapView.removeOverlays(self.showMapView.overlaysInLevel(MKOverlayLevel.AboveRoads))

            for route in response.routes {
                for step in route.steps {
                    print(step.distance.ft)
                    if step.distance.ft >= 528 {
                        self.turnbyturnStepDistance.append("\(Double(round(10*step.distance.mi)/10)) mi.")
                        self.turnbyturnStepIns.append("\(step.instructions)")
                        
                    } else if step.distance.ft < 528 {
                        self.turnbyturnStepDistance.append("\(Int(step.distance.ft)) ft.")
                        self.turnbyturnStepIns.append("\(step.instructions)")
                    }
                    print(step.instructions)
                }
                //self.turnbyturnStepDistance.removeAtIndex(0)
                //self.turnbyturnStepIns.removeAtIndex(0)
                self.tableView.reloadData()
                self.showMapView.addOverlay(route.polyline, level: MKOverlayLevel.AboveRoads)
            }
        }
    }
    
    
    //Create the request for source and use destination to
    func getDirections(){
        let request = MKDirectionsRequest()
        setDestination()
        //let destination = MKPlacemark(coordinate: DoctorBuilding, addressDictionary: nil)
        request.source = MKMapItem.mapItemForCurrentLocation()
        request.destination = MKMapItem(placemark: desPlace)

        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)

        directions.calculateDirectionsWithCompletionHandler{
            response, error in
            
            guard let response = response else {
                self.displayAlertWithTitle("Error",
                    message: "Error getting directions, please check your data connection and retry getting directions")
                //Set the map view to providence main tower and add pin.
                self.showMapView.setRegion(MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: 47.648755, longitude: -117.413009), 2000, 2000), animated: true)
                self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: 47.648755, longitude: -117.413009)
                self.pointAnnotation.title = "Providence Sacred Heart"
                self.showMapView.addAnnotation(self.pointAnnotation)
                return
            }
            self.showMapView(response)
        }
    }
    
    
    
    // Create the route and output steps to text view
    func showMapView(response: MKDirectionsResponse) {
        for route in response.routes {
            showMapView.addOverlay(route.polyline, level: MKOverlayLevel.AboveRoads)
            
            for step in route.steps {
                print(step.distance.ft)
                if step.distance.ft >= 528 {
                    turnbyturnStepDistance.append("\(Double(round(10*step.distance.mi)/10)) mi.")
                    turnbyturnStepIns.append("\(step.instructions)")

                } else if step.distance.ft < 528 {
                    turnbyturnStepDistance.append("\(Int(step.distance.ft)) ft.")
                    turnbyturnStepIns.append("\(step.instructions)")
                }
                print(step.instructions)
            }
            turnbyturnStepDistance.removeAtIndex(0)
            turnbyturnStepIns.removeAtIndex(0)
            tableView.reloadData()

        }
        let userLocation = showMapView.userLocation.coordinate
        print(userLocation)
        let region = MKCoordinateRegionMakeWithDistance(userLocation, 2000, 2000)
        if(userLocation.latitude == 0.0 && userLocation.longitude == 0.0){
            showMapView.userTrackingMode = MKUserTrackingMode.Follow
            curLocationButton.setImage(UIImage(named: "NearMeFilled100.png"), forState: .Normal)
            counterForCurLocationButton = 1

        }
        else {
            showMapView.setRegion(region, animated: true)
        }
        scheduledTimerWithTimeInterval()

    }
    
    // Renders the line for the directions
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.blueColor()
            renderer.lineWidth = 5.0
            return renderer
    }
    
    func mapView(mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        let tempView = mapView.subviews.first! as UIView
        let listOfGestures = tempView.gestureRecognizers! as [UIGestureRecognizer]
        for recognizer in listOfGestures {
            if recognizer.state == UIGestureRecognizerState.Began || recognizer.state == UIGestureRecognizerState.Ended{
                self.regionChangeIsFromUserInteraction = true
                break
            }
        }
    }
    
    //Periodically checks the mapView for a change
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if self.regionChangeIsFromUserInteraction || (showMapView.userTrackingMode == MKUserTrackingMode.None && showMapView.userTrackingMode != MKUserTrackingMode.Follow && showMapView.userTrackingMode != MKUserTrackingMode.FollowWithHeading) {
            self.regionChangeIsFromUserInteraction = false
            showMapView.userTrackingMode = MKUserTrackingMode.None
            curLocationButton.setImage(UIImage(named: "NearMe100.png"), forState: .Normal)
            counterForCurLocationButton = 0

        }
    }
    

    func locationManager(manager: CLLocationManager,
        didChangeAuthorizationStatus status: CLAuthorizationStatus){
            
            print("The authorization status of location " +
                "services is changed to: ", terminator: "")
            
            switch CLLocationManager.authorizationStatus(){
            case .Denied:
                print("Denied")
            case .NotDetermined:
                print("Not determined")
            case .Restricted:
                print("Restricted")
            default:
                print("Authorized")
                getDirections()
            }
    }
    
    func displayAlertWithTitle(title: String, message: String){
        let controller = UIAlertController(title: title,
            message: message,
            preferredStyle: .Alert)
        
        controller.addAction(UIAlertAction(title: "OK",
            style: .Default,
            handler: nil))
        
        presentViewController(controller, animated: true, completion: nil)
        
    }
    
    /* Add the pin to the map and center the map around the pin */
    func statusCheck() {
        /* Are location services available on this device? */
        if CLLocationManager.locationServicesEnabled(){
            
            /* Do we have authorization to access location services? */
            switch CLLocationManager.authorizationStatus(){
            case .Denied:
                /* No */
                displayAlertWithTitle("Not Determined",
                    message: "Location services are not allowed for this app, please change your settings to allow location services")

                
            case .NotDetermined:
                /* We don't know yet, we have to ask */
                locationManager = CLLocationManager()
                if let manager = self.locationManager{
                    manager.delegate = self
                    manager.requestWhenInUseAuthorization()
                }

            case .Restricted:
                /* Restrictions have been applied, we have no access
                to location services */
                displayAlertWithTitle("Restricted",
                    message: "Location services are not allowed for this app, please change your settings to allow location services")

                
            default:
                getDirections()
            }
            
            
        } else {
            /* Location services are not enabled.
            Take appropriate action: for instance, prompt the
            user to enable the location services */
            print("Location services are not enabled")
        }
        
    }

    //MARK - Actions
    @IBAction func OpenAppleMaps(sender: AnyObject, forEvent event: UIEvent) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://maps.apple.com/?saddr=\(showMapView.userLocation.coordinate.latitude),\(showMapView.userLocation.coordinate.longitude)&daddr=\(desPlace.coordinate.latitude),\(desPlace.coordinate.longitude)&dirflg=d")!)
    }
    
    //Action for sensing pan gesture on map to tell if UserTrackingMode changed
    @IBAction func moveMap(sender: AnyObject) {
    
        if showMapView.userTrackingMode == MKUserTrackingMode.None{
            curLocationButton.setImage(UIImage(named: "NearMe100.png"), forState: .Normal)
            print("Map Moved")
        }
    }
    //Action for curLocationButton to follow user when pressed, or follow with heading when pressed twice
    @IBAction func centerRegionToLocation(sender: AnyObject, forEvent event: UIEvent) {
        
        if counterForCurLocationButton == 1 && showMapView.userTrackingMode != MKUserTrackingMode.None{
            showMapView.userTrackingMode = MKUserTrackingMode.FollowWithHeading
            //curLocationButton.highlighted = true
            curLocationButton.setImage(UIImage(named: "NorthDirectionFilled100.png"), forState: .Normal)
            counterForCurLocationButton = 2
        }else if (counterForCurLocationButton == 2 && (showMapView.userTrackingMode == MKUserTrackingMode.Follow || showMapView.userTrackingMode == MKUserTrackingMode.FollowWithHeading)) {
            showMapView.userTrackingMode = MKUserTrackingMode.None
            curLocationButton.setImage(UIImage(named: "NearMe100.png"), forState: .Normal)
            counterForCurLocationButton = 0
        }else if showMapView.userTrackingMode == MKUserTrackingMode.None{
            showMapView.userTrackingMode = MKUserTrackingMode.Follow
            //curLocationButton.selected = true
            curLocationButton.setImage(UIImage(named: "NearMeFilled100.png"), forState: .Normal)
            counterForCurLocationButton = 1
        }
    }
    /*
    @IBOutlet weak var outHeight: NSLayoutConstraint!
    @IBAction func hideView(sender: AnyObject) {
        let constChange: CGFloat! = (UIScreen.mainScreen().nativeScale * 245.5) / 2//(UIScreen.mainScreen().nativeBounds.height (245.5/568)) / UIScreen.mainScreen().nativeScale
        if !hidden {
            self.viewHeight.constant += constChange
            self.viewBottomHeight.constant -= constChange
            self.directionsOutputHeight.constant += constChange
            self.dirOutBottomHeight.constant -= constChange
            self.DetailsButton.setTitle("Show Details", forState: .Normal)
            print(UIScreen.mainScreen().nativeScale)
            print(UIScreen.mainScreen().nativeBounds)
            print(screenSize.height * (245.5/568))
            print(screenSize.height)
            print(screenSize.width)
            hidden = true
        } else {
            self.viewHeight.constant -= constChange
            self.viewBottomHeight.constant += constChange
            self.directionsOutputHeight.constant -= constChange
            self.dirOutBottomHeight.constant += constChange
            self.DetailsButton.setTitle("Hide Details", forState: .Normal)
            hidden = false
        }
    }*/

}

